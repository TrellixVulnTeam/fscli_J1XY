# -*- coding: utf-8 -*-

"""
Init command to scaffold a project app from a template
"""
import click

from fscli.cli.main import pass_context

@click.command(
    "init",
    short_help="Init an JD Cloud Serverless application.",
    context_settings=dict(help_option_names=["-h", "--help"]),
)

@pass_context
def cli(ctx):
    print("JD Cloud Serverless Init Command")
    pass