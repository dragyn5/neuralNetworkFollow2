require 'ruby2d'

class NeuralNetwork
  def initialize(size2)
    / first is input second is bias/ 
    @nn1 = [[0,0],[1,0]]
    @w1, @nn2, @w2 = [],[],[]
    @learningRate = 0.05

    (size2*@nn1.size).times do
      @w1.push(randomNumber)
    end 
    size2.times do
      @nn2.push([0,randomNumber])
    end
    (size2*@nn2.size).times do
      @w2.push(randomNumber)
    end
    @nn3 = [[0, randomNumber],[0, randomNumber],[0, randomNumber],[0, randomNumber]]
  end

  def randomNumber
    return rand(-1.0..1.0)
  end

  def calculateN2
    @nn2.size.times do |x|
      @nn2[x][0] = sigmoid(@w1[x*2]*@nn1[0][0] + @w1[x*2+1]*@nn1[1][0] + @nn2[x][1])
    end
  end

  def calculateN3
    @nn3.size.times do |x|
      @nn3[x][0] = sigmoid(@w2[x*2]*@nn2[0][0] + @w2[x*2+1]*@nn2[1][0] + @w2[x*2+2]*@nn2[2][0] + @nn3[x][1])
      / needs revised to accomidate different sized networks/
    end
  end

  def squaredCost(target)
    prediction = output
    error_x = prediction[0] - target[0]
    error_y = prediction[1] - target[1]
    cost_x = (prediction[0] - target[0])**2
    cost_y = (prediction[1] - target[1])**2
    nn2_cost = [cost_x * @w2[0] + cost_y * @w2[1], @w2[2] * cost_x + @w2[3] * cost_y, @w2[4] * cost_x + @w2[5] * cost_y]
    nn1_cost = [nn2_cost[0] * @w1[0] + nn2_cost[1] * @w1[1] + nn2_cost[2] * @w1[2], nn2_cost[0] * @w1[3] + nn2_cost[1] * @w1[4] + nn2_cost[2] * @w1[5]]
    return cost_x, cost_y, target, prediction
    / train output layer biases /
    
  end

  def learn(xytargetArray)
    derivitiveNX = 2*(xytargetArray[3][0] - xytargetArray[2][0])
    weightDerivitiveNX = 
  end



  def sigmoid(inputValue)
    return 1/(1+2.7182818284590452353602874713527**(-inputValue))
  end

  def output
    / x prediction, y prediction /
    return [@nn3[0][0], @nn3[1][0]]
  end

  def runNeural(input1, input2)
    @nn1[0][0] = input1
    @nn1[1][0] = input2
    calculateN2
    calculateN3
    p output
  end
end


@nn = NeuralNetwork.new(3)
@nn.runNeural(1,0)