from django import forms
from .models import HouseSizeChoices, FoodChoices, WaterAppliance

class MemberDetailForm(forms.Form):
    """
    Class representing the form needed to change the details.

    """
    members = forms.IntegerField(min_value=1)
    house_size = forms.ChoiceField(choices=HouseSizeChoices.choices)
    food_choices = forms.ChoiceField(choices=FoodChoices.choices)
    water_consumption = forms.ChoiceField(choices=WaterAppliance.choices, initial=WaterAppliance.NONE)
    water_frequency = forms.IntegerField(min_value=1, max_value=10)
    purchases = forms.IntegerField(max_value=10, min_value=0)
    waste_production = forms.IntegerField(min_value=0, max_value=4)
    recycle = forms.IntegerField(max_value=6, min_value=0)
    transport_car = forms.IntegerField(min_value=0)
    transport_public = forms.IntegerField(min_value=0)
    transport_air = forms.IntegerField(min_value=0)