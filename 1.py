import os
import json

class Champion:
    def __init__(self, name, level):
        self.name = name
        self.level = level
        self.stats = {}

    def add_stat(self, stat_name, level_one_stat=0, stat_per_level=0, base_stat=0, bonus_stat=0, total_stat=0):
        # base_stat, total_stat math formula
        base_stat = level_one_stat + stat_per_level * (self.level - 1) * (0.7025 + 0.0175 * (self.level - 1))
        total_stat = base_stat + bonus_stat

        self.stats[stat_name] = {
            'level_one_' + stat_name: level_one_stat,
            stat_name + '_per_level': stat_per_level,
            'base_' + stat_name: base_stat,
            'bonus_' + stat_name: bonus_stat,
            'total_' + stat_name: total_stat
        }

# read champion data and stat names from JSON file
champion_data_file = "data/quality_data/info.json"
with open(champion_data_file) as f:
    champion_data = json.load(f)
    champion_name = champion_data.get("champion", {}).get("name")
    champion_level = champion_data.get("champion", {}).get("level")
    stat_names = champion_data.get("stats", [])

# construct file path based on champion name for .json
champion_file_path = os.path.join("data", "quality_data", "Champions", f"{champion_name}.json")
print("File path:", champion_file_path)

# read champion stats from the file
with open(champion_file_path) as f:
    champion_stats = json.load(f)

# create Champion instance with read data
champion = Champion(champion_name, champion_level)
for stat_name in stat_names:
    level_one_stat = champion_stats.get('level_one_' + stat_name, 0)
    stat_per_level = champion_stats.get(stat_name + '_per_level', 0)
    champion.add_stat(stat_name, level_one_stat, stat_per_level)



# Print the stats to the console
print(champion.stats)
print(champion.name)
print(champion.level)
print(stat_names)

