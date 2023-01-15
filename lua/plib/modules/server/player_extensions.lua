local ArgAssert = ArgAssert

local PLAYER = FindMetaTable( 'Player' )

do

    local util_IsValidModel = util.IsValidModel
    local hook_Run = hook.Run
    local assert = assert

    local ENTITY = FindMetaTable( 'Entity' )

    function PLAYER:SetModel( model )
        ArgAssert( model, 1, 'string' )
        assert( util_IsValidModel( model ), 'Model must be valid!' )

        local result = hook_Run( 'OnPlayerModelChange', self, model )
        if (result == false) then
            model = self:GetModel()
        elseif isstring( result ) then
            model = result
        end

        self.m_PreviousModel = self:GetModel()

        ENTITY.SetModel( self, model )
        hook_Run( 'PlayerModelChanged', self, model )
    end

end

function PLAYER:GetPreviousModel()
    if (self.m_PreviousModel) then
        return self.m_PreviousModel
    end

    return 'models/player.mdl'
end

do

    PLAYER.SetHullDuckOnServer = PLAYER.SetHullDuckOnServer or PLAYER.SetHullDuck

    function PLAYER:SetHullDuck( mins, maxs )
        ArgAssert( mins, 1, 'vector' )
        ArgAssert( maxs, 2, 'vector' )

        if (mins[3] > 0) then return end
        if (maxs[3] <= 0) then return end

        self:SetNWVector( 'Hull Duck Mins', mins )
        self:SetNWVector( 'Hull Duck Maxs', maxs )

        self:SetHullDuckOnServer( mins, maxs )
    end

    PLAYER.SetHullOnServer = PLAYER.SetHullOnServer or PLAYER.SetHull
    function PLAYER:SetHull( mins, maxs )
        ArgAssert( mins, 1, 'vector' )
        ArgAssert( maxs, 2, 'vector' )

        if (mins[3] > 0) then return end
        if (maxs[3] <= 0) then return end

        self:SetNWVector( 'Hull Mins', mins )
        self:SetNWVector( 'Hull Maxs', maxs )

        self:SetHullOnServer( mins, maxs )
    end

end
