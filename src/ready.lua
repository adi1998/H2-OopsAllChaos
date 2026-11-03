local rewardStoresOverwrite = {
    "HubRewards",
    "RunProgress",
    "TartarusRewards",
    "TyphonBossRewards",
}

for _, storeName in ipairs(rewardStoresOverwrite) do
    game.RewardStoreData[storeName] = {
        {
            Name = "TrialUpgrade",
            AllowDuplicates = true,
        },
    }
end

for roomName, roomData in pairs(game.RoomData) do
    if roomData.EligibleRewards and game.Contains(roomData.EligibleRewards, "Boon") then
        print("Patching EligibleRewards for room:", roomName)
        roomData.EligibleRewards[game.GetIndex(roomData.EligibleRewards, "Boon")] = "TrialUpgrade"
    end
end

modutil.mod.Path.Wrap("SetTransformingTraitsOnLoot", function (base, lootData, upgradeChoiceData)
    game.RandomSynchronize(math.random(1,9))
    base(lootData, upgradeChoiceData)
end)