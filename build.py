from jinja2 import Environment, FileSystemLoader

colors = dict(
    base00='020202',  # Black
    base08='ef4631',  # Red
    base0B='04e34d',  # Green
    base0A='f7bb09',  # Yellow
    base0D='2292ec',  # Blue
    base0E='3f50b0',  # Magenta
    base0C='10b9ce',  # Cyan
    base05='b4b4b4',  # White
    base03='3c3a3b',  # Bright Black
    base08_bright='fa7157',  # Bright Red
    base0B_bright='68ea74',  # Bright Green
    base0A_bright='fec850',  # Bright Yellow
    base0D_bright='6aa7f0',  # Bright Blue
    base0E_bright='6c6fc0',  # Bright Magenta
    base0C_bright='64c7d8',  # Bright Cyan
    base07='ffffff',  # Bright White
    base09='b4b4b4',
    base0F='b4b4b4',
    base01='020202',
    base02='3c3a3b',
    base04='b4b4b4',
    base06='ffffff',
)


def split_rgb(colors):
    colors_list = list(colors.items())
    for k, v in colors_list:
        r, g, b = tuple(v[i:i + 2] for i in (0, 2, 4))
        colors[k + '_hex_r'] = r
        colors[k + '_hex_g'] = g
        colors[k + '_hex_b'] = b
        colors[k + '_dec_r'] = int(r, 16) / 255
        colors[k + '_dec_g'] = int(g, 16) / 255
        colors[k + '_dec_b'] = int(b, 16) / 255


if __name__ == '__main__':
    env = Environment(loader=FileSystemLoader('templates'))
    split_rgb(colors)
    for template_filename in (
        'colors/base16-tm.vim',
        'base16-tm.itermcolors',
        'base16-tm.sh',
    ):
        template = env.get_template(template_filename)
        with open(template_filename, 'w') as f:
            f.write(template.render(**colors))
