from django.db import models
from django.contrib.auth.models import User

# Create your models here.
class ScoreModel(models.Model):
    user_name = models.ForeignKey(User, on_delete=models.CASCADE)
    score = models.IntegerField(default=0)
    
    def __str__(self):
        return self.user_name + " at the score of " + str(self.score) 

class HouseSizeChoices(models.IntegerChoices):
    LARGE = (0, "LARGE")
    MEDIUM = (1, "MEDIUM")
    SMALL = (2, "SMALL")
    APARTMENT = (3, "APARTMENT")

class FoodChoices(models.IntegerChoices):
    MEAT_HIGH = (0, "Regular Meat")
    MEAT_LOW = (1, "Meat few times")
    VEG = (2, "Vegetarain")
    VEGAN = (3, "Vegan")
    PACKED = (4, "Prepackaged Food")

class WaterAppliance(models.IntegerChoices):
    WASHING_MACHINE = (0, "Washing Machine")
    DISHWASHER = (1, "Dishwasher")
    BOTH = (2, "Both")
    NONE = (3, "None")

# class MemberDetails(models.Model):
#     user_name = models.ForeignKey(User, to_field='id' ,on_delete=models.CASCADE)
#     members = models.IntegerField(default=1)
#     house_size = models.IntegerField(choices=HouseSizeChoices.choices, null=True)
#     food_choices = models.IntegerField(null=True, choices=FoodChoices.choices)
#     water_consumption = models.IntegerField(choices=WaterAppliance.choices, default=WaterAppliance.NONE)
#     water_frequency = models.IntegerField(default=1, max_length=10)
#     purchases = models.IntegerField(max_length=10, default=0)
#     waste_production = models.IntegerField(default=0, max_length=4)
#     recycle = models.TextField(max_length=6, default=0)
#     transport_car = models.IntegerField(default=0)
#     transport_public = models.IntegerField(default=0)
#     transport_air = models.IntegerField(default=0)


# class DetailForm(ModelForm):   
#     class Meta:
#         model = MemberDetails
#         fields = ['members', 'house_size', 'food_choices', 'water_consumption', 'water_frequency', 'purchases'
#         , 'waste_production', 'recycle', 'transport_car', 'transport_public', 'transport_air']
