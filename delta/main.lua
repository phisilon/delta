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

    objects={}
    objectsPos={}
    objectsType={}
    cubeCollisions={}
    sphereCollisions={}

    player={
        x=0,
        y=0,
        z=0,
        angle=0,
        latatude=0,
    }
    sphere(0,0,4,1,1,1,'assets/textures/earth.jpg','low')
    sphere(0,0,0,500,500,500,'assets/textures/space-sky.jpg','low')
end

function love.update(dt)
    movePlayer()
end

function love.draw()
    for o=1,#objects,1 do
        objects[o]:draw()
        --if cubeCollisions[(o*3)-2]
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

function cube(x,y,z,sx,sy,sz,texture)
    objects[#objects+1]=g3d.newModel('assets/models/cube.obj',texture,{x,y,z},nil,{sx,sy,sz})
    objectsType[#objectsType+1]='cube'
    objectsPos[#objectsType+1]=x
    objectsPos[#objectsType+1]=y
    objectsPos[#objectsType+1]=z

    cubeCollisions[#cubeCollisions+1]=x-((objectsPos[#objectsPos-2])/2)
    cubeCollisions[#cubeCollisions+1]=y-((objectsPos[#objectsPos-1])/2)
    cubeCollisions[#cubeCollisions+1]=z-((objectsPos[#objectsPos])/2)

    cubeCollisions[#cubeCollisions+1]=x-((objectsPos[#objectsPos-2])/2)
    cubeCollisions[#cubeCollisions+1]=y+((objectsPos[#objectsPos-1])/2)
    cubeCollisions[#cubeCollisions+1]=z-((objectsPos[#objectsPos])/2)

    cubeCollisions[#cubeCollisions+1]=x+((objectsPos[#objectsPos-2])/2)
    cubeCollisions[#cubeCollisions+1]=y+((objectsPos[#objectsPos-1])/2)
    cubeCollisions[#cubeCollisions+1]=z-((objectsPos[#objectsPos])/2)

    cubeCollisions[#cubeCollisions+1]=x+((objectsPos[#objectsPos-2])/2)
    cubeCollisions[#cubeCollisions+1]=y-((objectsPos[#objectsPos-1])/2)
    cubeCollisions[#cubeCollisions+1]=z-((objectsPos[#objectsPos])/2)

    cubeCollisions[#cubeCollisions+1]=x+((objectsPos[#objectsPos-2])/2)
    cubeCollisions[#cubeCollisions+1]=y-((objectsPos[#objectsPos-1])/2)
    cubeCollisions[#cubeCollisions+1]=z+((objectsPos[#objectsPos])/2)

    cubeCollisions[#cubeCollisions+1]=x-((objectsPos[#objectsPos-2])/2)
    cubeCollisions[#cubeCollisions+1]=y+((objectsPos[#objectsPos-1])/2)
    cubeCollisions[#cubeCollisions+1]=z+((objectsPos[#objectsPos])/2)

    cubeCollisions[#cubeCollisions+1]=x-((objectsPos[#objectsPos-2])/2)
    cubeCollisions[#cubeCollisions+1]=y+((objectsPos[#objectsPos-1])/2)
    cubeCollisions[#cubeCollisions+1]=z+((objectsPos[#objectsPos])/2)

    cubeCollisions[#cubeCollisions+1]=x+((objectsPos[#objectsPos-2])/2)
    cubeCollisions[#cubeCollisions+1]=y+((objectsPos[#objectsPos-1])/2)
    cubeCollisions[#cubeCollisions+1]=z+((objectsPos[#objectsPos])/2)
end

function sphere(x,y,z,sx,sy,sz,texture,poly)
    if poly=='low' then
        objects[#objects+1]=g3d.newModel('assets/models/sphere.obj',texture,{x,y,z},nil,{sx,sy,sz})
    elseif poly=='high' then
        objects[#objects+1]=g3d.newModel('assets/models/highpoly-sphere.obj',texture,{x,y,z},nil,{sx,sy,sz})
    end
    objectsType[#objectsType+1]='sphere'
    objectsPos[#objectsType+1]=x
    objectsPos[#objectsType+1]=y
    objectsPos[#objectsType+1]=z
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
    g3d.camera.lookAt(player.x,player.y,player.z,player.x+sin(player.angle),0,player.z+cos(player.angle))
end

function pointAtObject(object,time)
end