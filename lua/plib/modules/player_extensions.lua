if (SERVER) then

    local ArgAssert = ArgAssert
    local hook_Run = hook.Run

    local PLAYER = FindMetaTable( 'Player' )

    do

        local util_IsValidModel = util.IsValidModel
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

            ENTITY.SetModel( self, model )
            hook_Run( 'PlayerModelChanged', self, model )
        end

        function PLAYER:SetMoveType( moveType )
            self:SetNWInt( 'Move Type', moveType )
            ENTITY.SetMoveType( self, moveType )
            hook_Run( 'PlayerMoveTypeChanged', self, moveType )
        end

        function PLAYER:SetMoveCollide( moveCollideType )
            self:SetNWInt( 'Move Collide Type', moveCollideType )
            ENTITY.SetMoveCollide( self, moveCollideType )
            hook_Run( 'PlayerMoveCollideChanged', self, moveCollideType )
        end

    end

    PLAYER.SetHullDuckOnServer = PLAYER.SetHullDuckOnServer or PLAYER.SetHullDuck

    function PLAYER:SetHullDuck( mins, maxs )
        ArgAssert( mins, 1, 'vector' )
        ArgAssert( maxs, 2, 'vector' )

        if (mins[3] > 0) then return end
        if (maxs[3] <= 0) then return end

        self:SetNWVector( 'Hull Duck Mins', mins )
        self:SetNWVector( 'Hull Duck Maxs', maxs )

        self:SetHullDuckOnServer( mins, maxs )
        hook_Run( 'PlayerDuckHullChanged', self, mins, maxs )
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
        hook_Run( 'PlayerHullChanged', self, mins, maxs )
    end

end

local CMoveData = FindMetaTable( 'CMoveData' )

function CMoveData:RemoveKey( inKey )
    self:SetButtons( bit.band( self:GetButtons(), bit.bnot( inKey ) ) )
end
