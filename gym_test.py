import gym
env = gym.make('CartPole-v1')
for episode in range(200):
    observation = env.reset() #环境重置
    for timestep in range(100):
        env.render() #可视化
        print(observation)
        action = env.action_space.sample() #动作采样
        observation, reward, done, _ = env.step(action) #单步交互
        if done:
            print(observation)
            print("Episode {} finished after {} timestep".format(episode, timestep+1))
            break
env.close()


