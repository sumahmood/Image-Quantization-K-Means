include("kMeans.jl")
using PyPlot

function quantizeImage(img, b)
  Xold = imread(img)
  S = size(Xold)
  X = reshape(Xold,S[1]*S[2],S[3])

  k = 2^b
  model = kMeans(X,k,doPlot=false)
  y = model.predict(X)
  W = model.W

  return y, W, S[1], S[2]

end

function deQuantizeImage(yVals, WVals, numRows, numCols)
  imageMatrix = zeros(numRows, numCols, 3)

  counter = 1

  for j in 1:numCols
    for i in 1:numRows
      for k in 1:3
        imageMatrix[i,j,k] = WVals[yVals[counter],k]
      end
      counter += 1
    end
  end

  imshow(imageMatrix)

end
