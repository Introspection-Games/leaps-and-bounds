pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
-- leaps and bounds:
-- a squirrel game
-- by matt phillips
-- introspection games
-- game off 2019

-- globals
local dt, game_objects

function _init()
    dt = null
    game_objects = {}
    make_player('player', 20, 20)
end

function _update()
    -- update dt value
    if(dt == null) do
        local target_fps = stat(8)
        dt = 1 / target_fps
    end
    -- update all game objects
    local obj
    for obj in all(game_objects) do
        obj:update()
    end
end

function _draw()
    cls()
    -- draw all game objects
    local obj
    for obj in all(game_objects) do
        obj:draw()
    end
end

-- function that makes the player
function make_player(name, x, y)
    local props 
    props = {
        width = 12,
        height = 12,
        jump = 2,
        velocity_x = 0,
        velocity_y = 0,
        max_velocity_x = 3,
        min_velocity_x = 0,
        accel = 20,
        friction = 0.4,
        move_x = 0,
        move_y = 0,
        grounded = true,
        can_move = true,
        moving = false,
        update = function(self)
            -- calculate velocity
            if self.can_move then
                if btn(0) then
                    self.moving = true
					if self.grounded then
                        self.velocity_x += ((self.accel) * dt) * - 1
					end
                    self.facing_left = true
				end
                if btn(1) then
                    self.moving = true
					if self.grounded then
                        self.velocity_x += ((self.accel) * dt)
					end
                    self.facing_left = false
				end
            end
            if not btn(0) and not btn(1) then
                self.moving = false
            end

            -- apply friction
            if self.velocity_x > 1 then
                self.velocity_x -= self.friction
            elseif self.velocity_x < -1 then
                self.velocity_x += self.friction
            elseif self.velocity_x > -1 and self.velocity_x < 1 and not self.moving then
                self.velocity_x = 0
            end

            -- update position
            
            
        end,
        draw = function(self)
            sspr(0, 0, 24, 16, self.x, self.y)
            print(self.velocity_x)         
        end
    }
    make_game_object(name, x, y, props)
end

-- function that makes game objects
function make_game_object(name, x, y, props)
    local obj
    obj = {
        name=name,
        x=x,
        y=y,
        velocity_x=0,
        velocity_y=0,
        update=function(self)
        end,
        draw=function(self)
        end
    }
    if not(props == nil) then
        local k, v
        for k, v in pairs(props) do
            obj[k] = v
        end
    end
    add(game_objects, obj)
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000055000000005000000000000000000000005000000000000000000000000000000005550000000000000000000065500000000000000000000000000000
00000655500000005550000000055500000000005550000055500000000000500000000065550000000000000000000655500000000000000000000000000000
00000665500055555555000000065550000055555555000066550000000000555000000065500000005000000000000650000005000000000000000000000000
00000066505555556660000000066650555555556660000006665055555555555500000065505555005550000000000650000005550000000000000000000000
00000006655556666000000000000665555566666000000000066555555555666000000006555555555555000000000050555555555000000000000000000000
00000000005666006000000000000000556660000600000000000056666666600000000000006665556660000000000005555556660000000000000000000000
00000000006600000000000000000006660000000000000000000666000000060000000000000600666000000000000000566666000000000000000000000000
00000000066000000000000000000006000000000000000000000000000000000000000000000600006000000000000000660006000000000000000000000000
