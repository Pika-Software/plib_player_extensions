hook.Add('PlayerInitialized', 'PLib - Player Sync', function( ply )
    ply:SetNWVarProxy('Hull Mins', function( self, _, __, mins )
        self:SetHull( mins, select( -1, self:GetHull() ) )
    end)

    ply:SetNWVarProxy('Hull Maxs', function( self, _, __, maxs )
        self:SetHull( self:GetHull(), maxs )
    end)

    ply:SetNWVarProxy('Hull Duck Mins', function( self, _, __, mins )
        self:SetHullDuck( mins, select( -1, self:GetHullDuck() ) )
    end)

    ply:SetNWVarProxy('Hull Duck Maxs', function( self, _, __, maxs )
        self:SetHullDuck( self:GetHullDuck(), maxs )
    end)

    ply:SetNWVarProxy('Move Type', function( self, _, __, moveType )
        self:SetMoveType( moveType )
    end)

    ply:SetNWVarProxy('Move Collide Type', function( self, _, __, moveCollideType )
        self:SetMoveCollide( moveCollideType )
    end)
end)
