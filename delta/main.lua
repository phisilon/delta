function love.load()
    love.window.setTitle('delta')
    love.window.setMode(300,300)
    width, height, flags = love.window.getMode()
    pi=math.pi

    mapView=false

    player={
        x=0,
        y=0,
        z=0,
        dx=0,
        angle=0,
        latitude=0,
    }

    wall={
        x1={},
        y1={},
        z1={},

        x2={},
        y2={},
        z2={},

        x3={},
        y3={},
        z3={},

        x4={},
        y4={},
        z4={},

        screen={
            x1={0},
            y1={0},

            x2={0},
            y2={0},

            x3={0},
            y3={0},

            x4={0},
            y4={0},
        },

        color={
            r={},
            g={},
            b={},
        },
    }

    map={ 
           -1,-1,1,
           1,-1,1,
           1,1,1,
           -1,1,1,
           1,1,0,
    }

end

function love.update()
    playerMovement()
    map2wall()
end

function love.draw()
    draw3d()
end

function sin(n)
    return math.sin(n)
end

function cos(n)
    return math.cos(n)
end

function sqrt(n)
    return math.sqrt(n)
end

function rad2deg(n)
    return n*(180/pi)
end

function deg2rad(n)
    return n*(pi/180)
end

function playerMovement()
    if love.keyboard.isDown('a') then
        player.angle=player.angle-0.05
    elseif love.keyboard.isDown('d') then
        player.angle=player.angle+0.05
    end
    if love.keyboard.isDown('w') then
        player.x=player.x+sin(player.angle)*0.25
        player.z=player.z+cos(player.angle)*0.25
    elseif love.keyboard.isDown('s') then
        player.x=player.x-sin(player.angle)*0.25
        player.z=player.z-cos(player.angle)*0.25
    end
    --player.latitude=(love.mouse.getY()/800)+height/2
end

function draw3d()
    local f=300
    for v=1,#wall.x1,1 do
        local x=wall.x1[v]-player.x
        local y=wall.y1[v]-player.y
        local z=wall.z2[v]-player.z

        local fx=x*cos(player.angle)-z*sin(player.angle)
        local fy=y
        local fz=x*sin(player.angle)+z*cos(player.angle)

        local sx=fx
        local sy=y*cos(player.latitude)-fz*sin(player.latitude)
        local sz=y*sin(player.latitude)+fz*cos(player.latitude)

        wall.screen.x1[v]=(width/2)+(sx/sz)*f
        wall.screen.y1[v]=(height/2)+(sy/sz)*f
    end

    for v=1,#wall.x2,1 do
        local x=wall.x2[v]-player.x
        local y=wall.y2[v]-player.y
        local z=wall.z2[v]-player.z

        local fx=x*cos(player.angle)-z*sin(player.angle)
        local fy=y
        local fz=x*sin(player.angle)+z*cos(player.angle)

        local sx=fx
        local sy=y*cos(player.latitude)-fz*sin(player.latitude)
        local sz=y*sin(player.latitude)+fz*cos(player.latitude)

        wall.screen.x2[v]=(width/2)+(sx/sz)*f
        wall.screen.y2[v]=(height/2)+(sy/sz)*f
    end

    for v=1,#wall.x3,1 do
        local x=wall.x3[v]-player.x
        local y=wall.y3[v]-player.y
        local z=wall.z3[v]-player.z

        local fx=x*cos(player.angle)-z*sin(player.angle)
        local fy=y
        local fz=x*sin(player.angle)+z*cos(player.angle)

        local sx=fx
        local sy=y*cos(player.latitude)-fz*sin(player.latitude)
        local sz=y*sin(player.latitude)+fz*cos(player.latitude)

        wall.screen.x3[v]=(width/2)+(sx/sz)*f
        wall.screen.y3[v]=(height/2)+(sy/sz)*f
    end

    for v=1,#wall.x4,1 do
        local x=wall.x4[v]-player.x
        local y=wall.y4[v]-player.y
        local z=wall.z4[v]-player.z

        local fx=x*cos(player.angle)-z*sin(player.angle)
        local fy=y
        local fz=x*sin(player.angle)+z*cos(player.angle)

        local sx=fx
        local sy=y*cos(player.latitude)-fz*sin(player.latitude)
        local sz=y*sin(player.latitude)+fz*cos(player.latitude)

        wall.screen.x4[v]=(width/2)+(sx/sz)*f
        wall.screen.y4[v]=(height/2)+(sy/sz)*f
    end

    for v=1,#wall.screen.x1,1 do
        --if (wall.x4[v]-player.x)*sin(player.angle)+(wall.z4[v]-player.z)*cos(player.angle)>0 and 
           --(wall.x3[v]-player.x)*sin(player.angle)+(wall.z3[v]-player.z)*cos(player.angle)>0 and 
           --(wall.x2[v]-player.x)*sin(player.angle)+(wall.z2[v]-player.z)*cos(player.angle)>0 and 
           --(wall.x1[v]-player.x)*sin(player.angle)+(wall.z1[v]-player.z)*cos(player.angle)>0 then
            love.graphics.setColor(wall.color.r[v],wall.color.g[v],wall.color.b[v])
            drawWall(wall.screen.x1[v],wall.screen.x2[v],
                     wall.screen.y1[v],wall.screen.y2[v],
                     wall.screen.x3[v],wall.screen.x4[v],
                     wall.screen.y3[v],wall.screen.y4[v]
            )
           --else
            --return
           --end
    end        
end

function map2wall()
    for i=15,#map,15 do
        wall.x1[i/15]=map[i-14]
        wall.y1[i/15]=map[i-13]
        wall.z1[i/15]=map[i-12]
        wall.x2[i/15]=map[i-11]
        wall.y2[i/15]=map[i-10]
        wall.z2[i/15]=map[i-9]
        wall.x3[i/15]=map[i-8]
        wall.y3[i/15]=map[i-7]
        wall.z3[i/15]=map[i-6]
        wall.x4[i/15]=map[i-5]
        wall.y4[i/15]=map[i-4]
        wall.z4[i/15]=map[i-3]
        wall.color.r[i/15]=map[i-2]
        wall.color.g[i/15]=map[i-1]
        wall.color.b[i/15]=map[i]
    end
end

function drawWall(x1,x2,b1,b2,x3,x4,b3,b4)
    local a=0

    local dyb=b2-b1
    local dyt=b3-b4
    local dx=x2-x1
    local dt=x3-x4
    if dx==0 then
        dx=1
    end
    if dt==0 then
        dt=1
    end
    local xs=x1
    local ts=x3

    if x1<a then
        x1=a
    end
    if x2<a then
        x2=a
    end
    if x1>width-a then
        x1=width-a
    end
    if x2>width-a then
        x2=width-a
    end

    if x3<a then
        x3=a
    end
    if x4<a then
        x4=a
    end
    if x3>width-a then
        x3=width-a
    end
    if x4>width-a then
        x4=width-a
    end

    for x=x1,x2,1 do
        local y1=dyb*(x-xs+0.5)/dx+b1
        local y2=dyt*(x-ts+0.5)/dt+b3
        if y1<a then
            y1=a
        end
        if y2<a then
            y2=a
        end
        if y1>height-a then
            y1=height-a
        end
        if y2>height-a then
            y2=height-a
        end
        for y=y1,y2,1 do
            love.graphics.points(x,y)
        end
    end
end