from typing import TypedDict
from image_to_text.model.initial import InitialData
from image_to_text.model.ratio_spe import RatioSpecified
import json

class SpendingData(TypedDict):
    initialData: InitialData
    ratioSpecified: RatioSpecified
   
    def to_json(self) -> str:
        return 