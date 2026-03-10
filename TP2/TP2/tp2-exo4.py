import itertools
from unittest import result

from matplotlib.pylab import beta


myrelations = [
    {'A', 'B', 'C', 'G', 'H', 'I'},
    {'X', 'Y'}
]

mydependencies = [
    [ {'A'}, {'B'} ], #A->B
    [ {'A'}, {'C'} ], #A->C
    [ {'C', 'G'}, {'H'} ] , #CG ->H
    [ {'C', 'G'}, {'I'} ] , #CG ->I
    [ {'B'}, {'H'} ] #B->H
]


#Question 1
def printDependencies(F):
    for alpha, beta in F:
        print ("\t", alpha , " --> ", beta )


print("Résultat de la question 1 :")
printDependencies(mydependencies)


#Question 2
def printRelations(T):
    for R in T:
        print ("\t", R )


print("Résultat de la question 2 :")
printRelations(myrelations)


#Question 3
def powerSet(inputset):
    _result = []
    for r in range (1 , len ( inputset ) +1) :
        _result += map (set , itertools.combinations(inputset, r))
    return _result

print("Résultat de la question 3 :")
print(powerSet(myrelations[1]))


#Question 4
def computeAttributeClosure(F, K):
    K_plus, size = set(K), 0
    while size != len(K_plus):
        size = len(K_plus)
        for alpha, beta in F:
            if alpha.issubset(K_plus):
                K_plus.update(beta)
    return K_plus

print("Résultat de la question 4 :")
print(computeAttributeClosure(mydependencies, {'C', 'G'}))


#Question 5
def computeDependenciesClosure(F):
    R = set()
    for alpha, beta in F:
        R.update(alpha | beta)
    F_plus = []
    for K in powerSet(R):
        for beta in powerSet(computeAttributeClosure(F, K)):
            F_plus.append([K, beta])
    return F_plus

print("Résultat de la question 5 :")
printDependencies(computeDependenciesClosure([[{'A'}, {'B'}]]))


#Question 6
def isDependency(F, alpha, beta):
    return beta.issubset(computeAttributeClosure(F, alpha))

print("Résultat de la question 6 :")
print(isDependency(mydependencies, {'C', 'G'}, {'H'}))


#Question 7
def isSuperKey(F, R, K):
    return R.issubset(computeAttributeClosure(F, K))

print("Résultat de la question 7 :")
print(isSuperKey(mydependencies, myrelations[0], {'A', 'G'}))


#Question 8
def isCandidateKey (F, R, K):
    if not isSuperKey (F , R , K): return False
    for A in K:
        _K1 = set (K)
        _K1 . discard (A)
        if isSuperKey (F , R , _K1 ): return False
    return True

print("Résultat de la question 8 :")
print(isCandidateKey(mydependencies, myrelations[0], {'A', 'G'}))


#Question 9
def computeAllCandidateKeys(F, R):
    result = []
    for K in powerSet (R) :
        if isCandidateKey (F , R , K ):
            result . append (K)
    return result

print("Résultat de la question 9 :")
print(computeAllCandidateKeys(mydependencies, myrelations[0]))


#Question 10
def computeAllSuperKeys(F, R):
    result = []
    for K in powerSet(R) :
        if isSuperKey(F, R, K):
            result.append(K)
    return result


print("Résultat de la question 10 :")
print(computeAllSuperKeys(mydependencies, myrelations[0]))


#Question 11
def computeOneCandidateKey(F, R):
    K = set(R)
    while not isCandidateKey(F, R, K):
        for A in K:
            if isSuperKey(F, R, K.difference({A})):
                K.remove(A)
                break
    return K

print("Résultat de la question 11 :")
print(computeOneCandidateKey(mydependencies, myrelations[0]))


#Question 12
def isBCNFRelation(F, R):
    for K in powerSet(R):
        K_plus = computeAttributeClosure(F, K)
        Y = K_plus.difference(K)
        if not R.issubset(K_plus) and not Y.isdisjoint(R):
            return False, [K, Y & R ]
    return True, [{}, {}]

print("Résultat de la question 12 :")
print(isBCNFRelation(mydependencies, myrelations[0]))


#Question 13
def isBCNFRelations(F, T):
    for R in T:
        if isBCNFRelation(F, R) == False:
            return False, R
    return True, {}

print("Résultat de la question 13 :")
print(isBCNFRelations(mydependencies, myrelations))


#Question 14
def computeBCNFDecomposition(F, T):
    OUT, size = list(T), 0
    while size != len(OUT):
        size = len(OUT)
        for R in OUT:
            _isR_BCNF, [alpha, beta] = isBCNFRelation(F, R)
            if _isR_BCNF == False:
                if alpha | beta not in OUT:
                    OUT . append ( alpha | beta )
                if R. difference ( beta ) not in OUT:
                    OUT . append ( R. difference ( beta ) )
                OUT . remove (R)
                break
    return OUT

print("Résultat de la question 14 :")
print(computeBCNFDecomposition(mydependencies, myrelations))