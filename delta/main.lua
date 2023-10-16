g3d=require 'g3d'
function love.load()
    love.mouse.setVisible(false)
    love.window.setTitle('delta')
    love.window.setFullscreen(true, "desktop")
    width=love.graphics.getWidth()
    height=love.graphics.getHeight()
    pi=math.pi

    --initialize camera
    g3d.camera.fov=1
    g3d.camera.nearClip=0.01
    g3d.camera.farClip=1000
    g3d.camera.aspectRatio=love.graphics.getWidth()/love.graphics.getHeight()
    g3d.camera.position={0,0,0}
    g3d.camera.target={0,0,0}
    g3d.camera.up={0,-1,0}

    camera={
        pointing=false,
        pointTo={0,0,0},
    }

    time=0

    objects={}
    objectsName={}
    objectX={}
    objectY={}
    objectZ={}
    objectSize={x={},
                y={},
                z={},}

   player={
        x=0,
        y=0,
        z=0,
        angle=0,
        latatude=0,
        time=1,
        speed=0.05
    }

    lastKeyPressed=''

    test=false

    sphere(0,0,0,500,500,500,0,0,0,'assets/textures/space-sky.jpg','low','sky')
    sphere(4,0,0,1,1,1,pi/-10,pi/-10,pi/-10,'assets/textures/earth.jpg','low','earth')
    sphere(4,0,5,0.5,0.5,0.5,0,0,0,'assets/textures/moon.jpg','low','moon')
end

function love.update(dt)
    time=time+dt
    movePlayer()
    move('moon',math.cos(time)*5+4,sin(time),math.sin(time)*5)
    objects[3]:setRotation(0,time-pi/2,0)
    if love.keyboard.isDown('tab') then
        pointAtObject(name2num('moon'),200)
    else
        camera.pointing=false
    end
end

function love.draw()
    for o=1,#objects,1 do
        objects[o]:draw()
    end
    if test==true then
        love.graphics.rectangle('line',0,0,width,height)
    end
end

function love.keypressed(key, scancode, isrepeat)
    if key=='escape' then
        love.window.minimize()
    end
end

function love.mousemoved(x,y,dx,dy)
    a=5
    player.latatude=(y/400)+height/2
    player.angle=player.angle+(dx/300)
    if x>width-a then
        love.mouse.setX(a)
    elseif x<a then
        love.mouse.setX(width-a)
    end
end

function love.wheelmoved(x,y)
    if y>0 then
        --up
    elseif y<0 then
        --down
    end
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

function abs(n)
    return math.abs(n)
end

function cube(x,y,z,sx,sy,sz,texture,name)
    objects[#objects+1]=g3d.newModel('assets/models/cube.obj',texture,{x,y,z},nil,{sx,sy,sz})
    objectX[#objectX+1]=x
    objectY[#objectY+1]=y
    objectZ[#objectZ+1]=z
    objectsName[#objectsName+1]=name
    objectSize.x[#objectSize.x+1]=sx
    objectSize.y[#objectSize.y+1]=sy
    objectSize.z[#objectSize.z+1]=sz
end

function sphere(x,y,z,sx,sy,sz,rx,ry,rz,texture,poly,name)
    if poly=='low' then
        objects[#objects+1]=g3d.newModel('assets/models/sphere.obj',texture,{x,y,z},{rx,ry,rz},{sx,sy,sz})
    elseif poly=='high' then
        objects[#objects+1]=g3d.newModel('assets/models/highpoly-sphere.obj',texture,{x,y,z},{rx,ry,rz},{sx,sy,sz})
    end
    objectX[#objectX+1]=x
    objectY[#objectY+1]=y
    objectZ[#objectZ+1]=z
    objectsName[#objectsName+1]=name
    objectSize.x[#objectSize.x+1]=sx
    objectSize.y[#objectSize.y+1]=sy
    objectSize.z[#objectSize.z+1]=sz
end

function move(name,x,y,z)
    objects[name2num(name)]:setTranslation(x,y,z)
    objectX[name2num(name)]=x
    objectY[name2num(name)]=y
    objectZ[name2num(name)]=z
end

local lastAngle=0

function movePlayer()
    local oldX=player.x
    local oldY=player.y
    local oldZ=player.z
    local keypressed=false

    if love.keyboard.isDown('a') then
        player.x=player.x+(sin(player.angle-pi/2)*player.speed)
        player.z=player.z+(cos(player.angle-pi/2)*player.speed)
        keypressed=true
        lastKeyPressed='a'
    elseif love.keyboard.isDown('d') then
        player.x=player.x-(sin(player.angle-pi/2)*player.speed)
        player.z=player.z-(cos(player.angle-pi/2)*player.speed)
        keypressed=true
        lastKeyPressed='d'
    end
    if love.keyboard.isDown('w') then
        player.x=player.x+(sin(player.angle)*player.speed)
        player.z=player.z+(cos(player.angle)*player.speed)
        keypressed=true
        lastKeyPressed='w'
    elseif love.keyboard.isDown('s') then
        player.x=player.x-(sin(player.angle)*player.speed)
        player.z=player.z-(cos(player.angle)*player.speed)
        keypressed=true 
        lastKeyPressed='s'
    end

    if keypressed==false then
        player.time=player.time+0.5
    else
        player.time=1
        lastAngle=player.angle
    end

    if player.time<60 then
        if lastKeyPressed=='a' then
            player.x=player.x+(sin(lastAngle-pi/2)*player.speed)/player.time
            player.z=player.z+(cos(lastAngle-pi/2)*player.speed)/player.time
        elseif lastKeyPressed=='d' then
            player.x=player.x-(sin(lastAngle-pi/2)*player.speed)/player.time
            player.z=player.z-(cos(lastAngle-pi/2)*player.speed)/player.time
        elseif lastKeyPressed=='w' then
            player.x=player.x+(sin(lastAngle)*player.speed)/player.time
            player.z=player.z+(cos(lastAngle)*player.speed)/player.time
        elseif lastKeyPressed=='s' then
            player.x=player.x-(sin(lastAngle)*player.speed)/player.time
            player.z=player.z-(cos(lastAngle)*player.speed)/player.time
        end
    end

    if camera.pointing==false then
        g3d.camera.lookAt(player.x,player.y,player.z,player.x+sin(player.angle),sin(player.latatude),player.z+cos(player.angle))
    else
        g3d.camera.lookAt(player.x,player.y,player.z,camera.pointTo[1],camera.pointTo[2],camera.pointTo[3])
    end
end

function pointAtObject(object,time)
    camera.pointing=true
    camera.pointTo[1]=objectX[object]
    camera.pointTo[2]=objectY[object]
    camera.pointTo[3]=objectZ[object]
end

function name2num(name)
    for o=1,#objectsName,1 do
        if objectsName[o]==name then
            return o
        end
    end
end

function num2name(num)
    return objectsName[num]
end