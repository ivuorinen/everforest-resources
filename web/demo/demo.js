// Everforest Demo JavaScript

document.addEventListener('DOMContentLoaded', function() {
    const themeControls = document.querySelectorAll('input[name="theme"]');
    const body = document.body;

    // Theme switching functionality
    themeControls.forEach(control => {
        control.addEventListener('change', function() {
            const theme = this.value;

            // Remove existing theme attributes
            body.removeAttribute('data-theme');

            // Apply new theme
            if (theme !== 'auto') {
                body.setAttribute('data-theme', theme);
            }
        });
    });

    // Initialize with auto theme
    const autoControl = document.querySelector('input[value="auto"]');
    if (autoControl) {
        autoControl.checked = true;
    }
});
