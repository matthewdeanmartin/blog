import datetime

AUTHOR = 'Matthew Martin'
SITENAME = "Matt's Blog"
SITESUBTITLE = "Not sure what I'm doing yet"
SITEURL = 'http://wakayos.com/blog'
TIMEZONE = "EST"

# can be useful in development, but set to False when you're ready to publish
RELATIVE_URLS = True

GITHUB_URL = 'http://github.com/matthewdeanmartin/'
# DISQUS_SITENAME = "blog-notmyidea"
REVERSE_CATEGORY_ORDER = True
# LOCALE = "C"
DEFAULT_PAGINATION = 4
# DEFAULT_DATE = (2012, 3, 2, 14, 1, 1)

FEED_ALL_RSS = 'feeds/all.rss.xml'
CATEGORY_FEED_RSS = 'feeds/{slug}.rss.xml'

LINKS = (
    #     ('Biologeek', 'http://biologeek.org'),

)

SOCIAL = (
    ('twitter', 'http://twitter.com/mistersql'),
    ('mastodon', 'http://mastodon.social/@mistersql'),
    ('github', 'http://github.com/matthewdeanmartin'),
)

# global metadata to all the contents
# DEFAULT_METADATA = {'yeah': 'it is'}

# path-specific metadata
# EXTRA_PATH_METADATA = {
#     'extra/robots.txt': {'path': 'robots.txt'},
#     }

# static paths will be copied without parsing their contents
# STATIC_PATHS = [
#     'images',
#     'extra/robots.txt',
#     ]

# custom page generated with a jinja2 template
# TEMPLATE_PAGES = {'pages/jinja2_template.html': 'jinja2_template.html'}

# there is no other HTML content
READERS = {'html': None}

# code blocks with line numbers
PYGMENTS_RST_OPTIONS = {'linenos': 'table'}

# foobar will not be used, because it's not in caps. All configuration keys
# have to be in caps
# foobar = "barbaz"


# Hyde Theme

BIO = "I'm a tech lead for a DC Area contracting company. I write python and think a lot about build scripts."
PROFILE_IMAGE = "blue_face.jpg"
today = datetime.date.today()
year = today.year
FOOTER_TEXT = f"(C) {year} Matthew Martin"
# COLOR_THEME - base colors for the theme, choose from 08 to 0f, refer to https://github.com/poole/hyde for details.
# FONT_AWESOME_CSS - URL to get Font Awesome as CSS
# FONT_AWESOME_JS - URL to get Font Awesome as Javascript
# FONT_ACADEMICONS - set to True to fetch the Academicons font
