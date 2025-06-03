from time import sleep
import asyncio

async def asyncgenerator():
    yield 1
    sleep(2)
    yield 2
    sleep(0.5)
    yield 3
    sleep(0.4)
    yield [1, 2]

async def coroutine():
    async for num in asyncgenerator():
        print(num)

asyncio.run(coroutine())

print("Waiting for async thread")

