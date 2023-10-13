g3d=require 'g3d'
function love.load()
    love.window.setTitle('delta')
    love.window.setMode(1000,750)
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

   player={
        x=0,
        y=0,
        z=0,
        angle=0,
        latatude=0,
    }
    sphere(0,0,0,500,500,500,0,0,0,'assets/textures/space-sky.jpg','low','sky')
    sphere(4,0,0,1,1,1,pi/-10,pi/-10,pi/-10,'assets/textures/earth.jpg','low','earth')
    sphere(4,0,5,0.5,0.5,0.5,0,0,0,'assets/textures/moon.jpg','low','moon')
end

function love.update(dt)
    time=time+dt
    movePlayer()
    objects[3]:setTranslation(math.cos(time)*5+4,sin(time),math.sin(time)*5)
    objectX[3]=math.cos(time)*5+4
    objectY[3]=sin(time)
    objectZ[3]=math.sin(time)*5
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
end

function love.keypressed(key, scancode, isrepeat)
    if key=='escape' then
        love.window.minimize()
    end
end

function love.mousemoved(x,y,dx,dy)
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

function cube(x,y,z,sx,sy,sz,texture,name)
    objects[#objects+1]=g3d.newModel('assets/models/cube.obj',texture,{x,y,z},nil,{sx,sy,sz})
    objectX[#objectX+1]=x
    objectY[#objectY+1]=y
    objectZ[#objectZ+1]=z
    objectsName[#objectsName+1]=name
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
end

function movePlayer()
    if love.keyboard.isDown('a') then
        player.angle=player.angle-0.075
    elseif love.keyboard.isDown('d') then
        player.angle=player.angle+0.075
    end
    player.latatude=(love.mouse.getY()/(height*2))+height/2
    if love.keyboard.isDown('w') then
        player.x=player.x+sin(player.angle)*0.1
        player.z=player.z+cos(player.angle)*0.1
    elseif love.keyboard.isDown('s') then
        player.x=player.x-sin(player.angle)*0.1
    player.z=player.z-cos(player.angle)*0.1
    end
    if camera.pointing==false then
        g3d.camera.lookAt(player.x,player.y,player.z,player.x+sin(player.angle),0,player.z+cos(player.angle))
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
