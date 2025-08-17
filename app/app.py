from fastapi import FastAPI
from .api import router

app = FastAPI(title="Python Trading Task API")

app.include_router(router)