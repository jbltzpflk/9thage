
class Regiment
	def record(*args)
		@history.append @controller.newEvent *args
	end

	def animosityTest
		return false unless subjectAnimosity?
		animosityRoll = Dice.d6()
		record :roll, self, :animosityTest, animosityRoll
		record :test, self, :animosity, false, "roll = #{animosityRoll}" and return false if animosityRoll > 1
		quellAnimosity! and return false if quellAnimosity?
		record :test, self, :animosity, true, "failed Animosity test" and return true 
	end

	def animosity!
		animosityRoll = Dice.d6()
		record :roll, self, :animosity, animosityRoll
		animosityGetEm and return if animosityRoll == 1
		animosityShowEm and return if animosityRoll == 6
		animositySquabble
	end

	def quellAnimosity?()
		quellers = regiment.figures.filter {|f| f.hasRule :quellAnimosity}
		queller = quellers.first
		record :predicate, self, :quellAnimosity, false and return false unless queller
		record :predicate, self, :quellAnimosity, true and return true
	end

	def quellAnimosity!
		quellers = regiment.figures.filter {|f| f.hasRule :quellAnimosity}
		queller = quellers.first
		quellRoll = Dice.d6()
		queller.record :roll, 
		inflict quellRoll hits @S5 #on regiment, excluding the BlackOrc character with highest Ld in regiment.
		# no panic test
		record controller.newEvent :predicate, self, :animosity, false, "quelled" 
	end

	def subjectAnimosity?
		record :predicate, self, :animosity, false, "no animosity rule"      and return false unless self.hasAnyWithRule :animosity
		record :predicate, self, :animosity, false, "insufficient figures"   and return false if self.figureCount < 5
		record :predicate, self, :animosity, false, "already in combat"      and return false if self.isFighting
		record :predicate, self, :animosity, false, "garrisoning a building" and return false if self.isGarrisoning
		record :predicate, self, :animosity, false, "fleeing"                and return false if self.isFleeing
		record :predicate, self, :animosity, false, "not on battlefield"     and return false if self.isDeployed == false
		record :predicate, self, :animosity, true,  "subject to Animosity" and return true
	end

	def animosityGetEm
		# find nearest friendly in range with Animosity
		range = 12
		alliedRegiments = @army.allies.collect{ |a| a.regiments }
		alliedRegiments.flatten!
		targets = alliedRegiments.select {|r| r.hasRule :animosity } # all that have the rule, not all that take the test.
		targets.select!{|r| r.distance(self) <= range} 
		targets = targets.sortBy{|r| r.distance(self) }
		target = targets.first
		record :ruleFail, self, :animosity, :animosityGetEm, "no available targets" and return animositySquabble unless target
		record :ruleAction, self, :animosity, :animosityGetEm, target
		firstRoll = self.isHorde? ? Dice.roll2D6() : Dice.D6()
		a = Attack.new self, target, :s=>3, :a=>firstRoll, :state=>:hit
		# record a
		secondRoll = target.isHorde? ? Dice.roll2D6() : Dice.D6()
		b = Attack.new target, self, :s=>3, :a=>secondRoll, :state=>:hit
		# record b
		# resolve a
		# resolve b
		# no panic test from either
		updateState [MOVED, CAST, SHOT]
		target.updateState([MOVED,CAST,SHOT])
		# self  updatestate  MOVED
		# target updatestate MOVED
	end

	def getChargables
		chargables = @army.opponents.collect{|o| o.regiments}
		chargables.flatten!
		chargables.select! {|r| r.distance(self) <= range} 
		chargables.sortBy! {|r| r.distance(self) }
	end

	def animositySquabble
		target = getChargables.first
		animositySquabbleCharging(target) and return if target
		updateState([MOVED,CAST,SHOT])
		record :ruleAction, self, :animosity, :animositySquabble, nil
	end

	def animositySquabbleCharging(target)
		record :ruleAction, self, :animosity, :animositySquabble, target
		@controller.queue BattleTime.new(:currentTurn,:movement,:declare), :declare, self, target
	end

	def animosityShowEm
		chargables = getChargables
		chargables.select!{|r| self.hasLOS(r)}
		target = chargables.first
		newDirection = target ? self.getVector(target) : @heading
		# attempt
			@controller.queue :immediate, :pivot, :self, newDirection
			@controller.queue :immediate, :move, :self, characteristic(:m)
		# if cant pivot to face target, pivot as far as possible, then move as far forward while keeping target in forward arc
		@controller.queue BattleTime.new(:currentTurn,:movement,:declare), :declare, self, target if target
	end

end


# add a trigger to any OG army to check animosity each SOT phase for all regiments with animosity.