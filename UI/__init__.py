# Re-export start_ui for package-level import
# Use lazy import to avoid importing UI.UI at package import time
# This prevents triggering multiprocessing setup when just importing UI components
def start_ui(runner=None):
    """Start the UI application
    
    Args:
        runner: Optional callable that takes a spec dict and returns results dict
    """
    from .UI import start_ui as _start_ui
    return _start_ui(runner=runner)

__all__ = ['start_ui']
