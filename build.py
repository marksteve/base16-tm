from jinja2 import Environment, FileSystemLoader

colors = dict(
    base00='3c3a3b',         # Black
    base01='5f5d5e',
    base02='858384',
    base03='acaaab',         # Bright Black
    base04='d6d3d5',
    base05='ededed',         # White
    base06='f2f2f2',
    base07='ffffff',         # Bright White
    base08='ef4631',         # Red
    base0B='5ec84e',         # Green
    base0A='f3a258',         # Yellow
    base0D='5268b4',         # Blue
    base0E='be48ad',         # Magenta
    base0C='53bed0',         # Cyan
    base08_bright='e29294',  # Bright Red
    base0B_bright='cacd84',  # Bright Green
    base0A_bright='eac1b5',  # Bright Yellow
    base0D_bright='aa89c1',  # Bright Blue
    base0E_bright='d386b6',  # Bright Magenta
    base0C_bright='bbc6e7',  # Bright Cyan
    base09='f3a258',         # Integers, Boolean, Constants, XML Attributes, Markup Link Url
    base0F='eac1b5',         # Deprecated, Opening/Closing Embedded Language Tags
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
