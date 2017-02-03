## Random Search in Python
import random as r

# sum function
def sum(list):
  if len(list) == 0:
    return 0
  else:
    return sum(list[1:]) + (list[0] ** 2.0)

# random vector
def randomList(minmax):
  i = 1
  list = []
  while i <= len(minmax):
    min = minmax[0]
    max = minmax[1]
    num = min + ((max - min) * r.random())
    list.append(num)
    i += 1
  return list

# search
def search(search_space, max_iter):
  best = None
  iter = 1
  while iter <= max_iter:
    candidate = {}
    candidate["vector"] = search_space
    candidate["best"] = sum(candidate["vector"])
    if best == None or (candidate["best"] < best["best"]):
      best = candidate
    iter += 1
  return best['best']

def main():
    size = 2
    minmax = [-5, 5]
    max_iter = 100

    search_space = randomList(minmax)
    best = search(search_space, max_iter)

    print best

if __name__ == '__main__':
    main()
