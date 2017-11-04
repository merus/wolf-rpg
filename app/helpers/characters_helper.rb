module CharactersHelper

	def skill_id(skill)
		"skill-table-#{skill.name.parameterize}"
	end

	def skill_prereqs(skill)
		if skill.required_skill then
			"#{skill_id(skill.required_skill)} #{skill_prereqs(skill.required_skill)}"
		else
			""
		end
	end

end
