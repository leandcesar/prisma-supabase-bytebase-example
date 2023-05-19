import asyncio
import logging

from prisma import Prisma

logging.basicConfig(level=logging.INFO)


async def main() -> None:
    db = Prisma()
    await db.connect()
    user = await db.user.create({"name": "John Lock"})
    logging.info(f"created user: {user.json(indent=2, sort_keys=True)}")
    found = await db.user.find_unique(where={"id": user.id})
    assert found is not None
    logging.info(f"found user: {found.json(indent=2, sort_keys=True)}")
    await db.disconnect()


if __name__ == "__main__":
    asyncio.run(main())
