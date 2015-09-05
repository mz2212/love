function checkHit(xEnt, yEnt, sXEnt, sYEnt,  xProj, yProj, sXProj, sYProj)
  return xEnt < xProj + sXProj and xProj < xEnt + sXEnt and yEnt < yProj + sYProj and yProj < yEnt + sYEnt
end
