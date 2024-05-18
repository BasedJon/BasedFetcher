-- Tooltip info below:
-- The first Attack critically strikes for \u003CphysicalDamage\u003E@EmpoweredQdamageTT@ physical damage\u003C/physicalDamage\u003E 
-- and grants Rengar \u003CattackSpeed\u003E@EmpoweredQAS@ Attack Speed\u003C/attackSpeed\u003E for @Effect3Amount@ seconds.
-- \u003Cbr\u003E\u003Cbr\u003E\u003Crules\u003EAutoattack damage increases to up to @CritDamageScalar@ based on Critical Strike Chance.
-- \u003C/rules\u003E\u003Cbr\u003E\u003Crules\u003EThis Ability's bonus damage is reduced by @TowerMod*100@% against structures.\u003C/rules\u003E"
-- End of tooltip.

-- Let's use @EmpoweredQdamageTT@ as an example, it can be referenced to this calculation in the rengar.bin

mSpellCalculations: map[hash,pointer] = {
    "EmpoweredQdamageTT" = GameCalculation {
        tooltipOnly: bool = true
        mFormulaParts: list[pointer] = {
            ByCharLevelBreakpointsCalculationPart {
                mLevel1Value: f32 = 30
                0x2deb550: f32 = 15
                mBreakpoints: list[embed] = {
                    Breakpoint {
                        mLevel: u32 = 9
                        0x57fdc438: f32 = 10
                    }
                }
            }
            StatByNamedDataValueCalculationPart {
                mStat: u8 = 2
                mDataValue: hash = totalempoweredadratio
            }
        }
    }

-- sometimes there are unresolved hash values, some of them can be resolved by simply rehashing the .bin, but some need to be guessed by hand
-- guessing hashes by hand currently is the main problem, however for now I did not find many instances where it is hard to find a formula for it
-- there migth be a better way for finding the hashes that I don't know of
-- going back to the formula, there are a few types of calculations, in this example it's "GameCalculation"
-- mFormulaParts are the parts of the calculation, so the end formula in this example will be 

ByCharLevelBreakpointsCalculationPart + StatByNamedDataValueCalculationPart = "EmpoweredQdamageTT"

-- "ByCharLevelBreakpointsCalculationPart" is a standardized formula used for calculating values per lvl, in this example the unsolved hash values are ValuePerLvl
-- in "StatByNamedDataValueCalculationPart" mStat means a champion's stat, I have the table for it, in this example it's AD,
-- mDataValue refers to a value in the rengar.bin called totalempoweredadratio (the only thing you need to resolve it is the ability's level)
