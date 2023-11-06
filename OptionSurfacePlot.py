import numpy
import matplotlib
import scipy
import enum 
from mpl_toolkits import mplot3d
from scipy.interpolate import RegularGridInterpolator

# We start by first creating a class that defines puts and calls
class OptionType(enum.Enum):
    CALL = 1.0
    PUT = -1.0

def OGPGBM(NPaths, NSteps, T, r , sigma, S_0):    
    Z = numpy.random.normal(0.0, 1.0, [NPaths, NSteps])
    X = numpy.zeros([NPaths, NSteps + 1])
    W = numpy.zeros([NPaths, NSteps + 1])
    time = numpy.zeros([NSteps + 1])
        
    X[:,0] = numpy.log(S_0)
    
    dt = T / float(NSteps)
    for i in range(0, NSteps):

        # Assuring that it samples from a standard normal N(0,1)
        if NPaths > 1:
            Z[:,i] = (Z[:,i] - numpy.mean(Z[:,i])) / numpy.std(Z[:,i])
        W[:,i + 1] = W[:,i] + numpy.power(dt, 0.5) * Z[:,i]
        X[:,i + 1] = X[:,i] + (r - 0.5 * sigma * sigma) * dt + sigma * (W[:,i+1] - W[:,i])
        time[i + 1] = time[i] + dt

    S = numpy.exp(X)
    paths = {"time":time,"S":S}
    return paths

# Black-Scholes option price
def BSOptionPrice(CallPut, S_0, K, sigma, t, T, r):
    K = numpy.array(K).reshape([len(K),1])
    d1 = (numpy.log(S_0 / K) + (r + 0.5 * numpy.power(sigma,2.0)) * (T-t)) / (sigma * numpy.sqrt(T - t))
    d2 = d1 - sigma * numpy.sqrt(T - t)
    if CallPut == OptionType.CALL:
        value = scipy.stats.norm.cdf(d1) * S_0 - scipy.stats.norm.cdf(d2) * K * numpy.exp(-r * (T-t))
    elif CallPut == OptionType.PUT:
        value = scipy.stats.norm.cdf(-d2) * K * numpy.exp(-r * (T-t)) - scipy.stats.norm.cdf(-d1) * S_0
    return value

def myPlot():
    myT = 1.001
    myR = 0.05
    mySigma = 0.4
    mySZero = 10.0
         
    # Setting up the grids for our plots
    StrikeGrid = numpy.linspace(mySZero/100.0, 1.5*mySZero, 50)
    TimeGrid = numpy.linspace(0.02, myT-0.02, 100)
    
    # Lambda functions
    CallOpt = lambda t,K : BSOptionPrice(OptionType.CALL, mySZero, K, mySigma, t, myT, myR)
    PutOpt = lambda t,K : BSOptionPrice(OptionType.PUT, mySZero, K, mySigma, t, myT, myR)
    
    # Prepare empty matrices for storing the results
    CallOptionMatrix = numpy.zeros([len(TimeGrid), len(StrikeGrid)])
    PutOptionMatrix = numpy.zeros([len(TimeGrid), len(StrikeGrid)])
    TMatrix = numpy.zeros([len(TimeGrid), len(StrikeGrid)])
    KMatrix = numpy.zeros([len(TimeGrid), len(StrikeGrid)])
    
    for i in range(0, len(TimeGrid)):
        TMatrix[i,:] = TimeGrid[i]
        KMatrix[i,:] = StrikeGrid
        CallOptionMatrix[i,:] = CallOpt(TimeGrid[i], StrikeGrid).transpose()
        PutOptionMatrix[i,:] = PutOpt(TimeGrid[i], StrikeGrid).transpose()

        
    # We now plot the surfaces as a function of time and strike

    # Surface for call option
    fig = matplotlib.pyplot.figure(1)
    ax = matplotlib.pyplot.figure().add_subplot(projection='3d')
    ax.plot_surface(TMatrix, KMatrix, CallOptionMatrix, color=[1,0.5,1])
    ax.legend()
    ax.set_xlabel('t')
    ax.set_ylabel('K')
    ax.view_init(elev=25., azim=191, roll=0)
    matplotlib.pyplot.title('Call option surface')    

    # Surface for put option
    fig = matplotlib.pyplot.figure(2)
    ax = matplotlib.pyplot.figure().add_subplot(projection='3d')
    ax.plot_surface(TMatrix, KMatrix, PutOptionMatrix, color=[1,0.5,1])
    ax.legend()
    ax.set_xlabel('t')
    ax.set_ylabel('K')
    ax.view_init(elev=20., azim=200, roll=0)
    matplotlib.pyplot.title('Put option surface')    
            
myPlot()