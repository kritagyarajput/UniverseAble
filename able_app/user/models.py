from django.db import models
from django.contrib.auth.models import User

# Create your models here.
class RecyclingChoices(models.TextChoices):
    GLASS = ("G", "GLASS")
    PLASTIC = ("PL", "PLASTIC")
    PAPER = ("P", "PAPER")
    ALUMINIUM = ("A", "ALUMINIUM")
    STEEL = ("S", "STEEL")
    FOODWASTE = ("FW", "FOODWASTE")
    NONE = ("N", "NONE")


class MemberDetails(models.Model):
    user_name = models.ForeignKey(User, to_field='id' ,on_delete=models.CASCADE)
    members = models.IntegerField(default=1)
    house_size = models.CharField(null=True, max_length=50)
    food_choices = models.CharField(null=True, max_length=50)
    water_consumption = models.IntegerField(default=0)
    water_frequency = models.IntegerField(default=1)
    purchases = models.IntegerField(null=True, default=0)
    waste_production = models.IntegerField(default=0)
    recycle = models.TextField(choices=RecyclingChoices.choices, null=False, default=RecyclingChoices.NONE)
    transport_car = models.IntegerField(default=0)
    transport_public = models.IntegerField(default=0)
    transport_air = models.IntegerField(default=0)
