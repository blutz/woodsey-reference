from django.db import models
from django.contrib.auth.models import AbstractUser, User
from jsonfield import JSONField

class CampUser(AbstractUser):
    camp_name = models.CharField(max_length=254)

class Position(models.Model):
    title = models.CharField(max_length=254)
    year = models.IntegerField()
    leaders = models.ManyToManyField('CoGroup', blank=True)
    acitve = models.BooleanField(default=True)

class CoGroup(models.Model):
    primary_position = models.ForeignKey(Position,
            related_name="primary_cogroups")
    other_positions = models.ManyToManyField(Position,
            blank=True,
            related_name="other_cogroups")
    cos = models.ManyToManyField(CampUser)

class Program(models.Model):
    STATUS_CHOICES = (
            ('IP', 'In Progress'),
            ('DC', 'Draft Complete'),
            ('RV', 'Reviewed'),
            ('AP', 'Approved'),
            ('CC', 'Complete'),
        )
    owner = models.ForeignKey(CoGroup)
    status = models.CharField(max_length=2, 
            choices=STATUS_CHOICES,
            default='IP')
    title = models.CharField(max_length=254)
    outcome = models.TextField(blank=True)
    indicators = JSONField(blank=True)
    steps = models.ManyToManyField('ProgramStep', blank=True, related_name="+")

class ProgramStep(models.Model):
    program = models.ForeignKey(Program)
    order = models.IntegerField(default=0)
    duration = models.IntegerField(blank=True,
            help_text="Duration of step in minutes")
    description = models.TextField(blank=True)
    materials = models.TextField(blank=True)
    notes = models.TextField(blank=True)

class ProgramComment(models.Model):
    time = models.DateTimeField(auto_now_add=True)
    user = models.ForeignKey(CampUser)
    program = models.ForeignKey(Program)
    comment = models.TextField()
