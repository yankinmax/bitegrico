# -*- coding: utf-8 -*-

from odoo import models, fields, api

class ExtraDescription(models.Model):
    _inherit = "product.template"

    specification = fields.Char(string='Specification', store=True)
    usage = fields.Char(string='Usage', store=True)
    features = fields.Char(string='Features', store=True)