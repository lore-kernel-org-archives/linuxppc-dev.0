Message-ID: <3973D3E6.578C8B5C@execpc.com>
Date: Mon, 17 Jul 2000 22:49:58 -0500
From: Joseph Garcia <jpgarcia@execpc.com>
MIME-Version: 1.0
To: Stephan Leemburg <pmud-bugs@jvc.nl>
CC: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: preliminary 3400 APM support for PMUD
Content-Type: multipart/mixed;
 boundary="------------1C732C24407074E821B3A976"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------1C732C24407074E821B3A976
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit

attached is a patch against pmud-0.6.1.tar.gz to add untested APM emulation
support for Ohare-based powerbooks.  I don't have access to a system to test it,
however the code used is based on that from my GKrellM-PMU plugin.  I tested
that code to be consistant with what Paul's Batmon displays.

Just my contribution to PMUD.  Any feedback is welcome.

Thanks for your time.

--
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group
--------------1C732C24407074E821B3A976
Content-Type: application/x-gzip;
 name="pmud-0.6-3400APM-jpg.patch.gz"
Content-Disposition: inline;
 filename="pmud-0.6-3400APM-jpg.patch.gz"
Content-Transfer-Encoding: base64

H4sICHfMczkAA3BtdWQtMC42LTM0MDBBUE0tanBnLnBhdGNoAIVWbW/aSBD+bH7FHFUjO7bB
a2NeQxXa0ijXvFSEXq/KIcuBNdkUbJ9tEqIq99tv9sVOSJq7iLAwO/Ps7DPPjFmwKAI720C6
3ixsp9FuzpO4yNhVs8jC+Y80XDTm1V7jJl3+Yr9m2/Z/xWvf6AJGaQakB8Tv+92+2wHXcZya
aZr/B66dJjH8vlkBwRi37zj9VksGHx6C7XtWB0zxfnhYgxq8YdGCRvBx/P7rUQ34X5qxuIj0
+ttFH+pWbAxqNjezCPQY3oFjwM+a+cQylCbQMAzYAD9ESQY6GzoDYHAAMS6maaD9Kbqzfeu4
Wzzg/pLN8AyeHOn0eHZy4ekBaA/inYMuYAhJSmO93lzQ22a4uKpbcB5MPn6b8Bw1ng46Hah8
zMpQ5qelNMuSTK9zFBYvocIxeNYa3bJCH/95PA0+jY5Pvk7GwvxQW7woOX5oXO8WQph2CytM
z2rpdrGcr9RS+u+Wj7h9130sH+lZXSSoZ3ll+bB4LKbw5fRrcHE6mkyD96PpVNOcbTvSmvuQ
0TTJCsjXIb5fhUVBs3vIi7CgsN/cDT8aT4M/xpOL4/MzHk9DHr+kBU8SIpat78KMwi3NcoYp
vuHxds1Gn88sXkAScRDQ18mCrgyxSePNGom3NY7+efz9ZDQ5Osf8LsYfh57F0dn7JPkhfB8G
v6b5RTdJ2wuiufCn1xs4De+BEHB6fd/r+/7rTL/sFKwO8R6p9pBl4oIp1paiGzWlR6twme99
OjkKRl9OuaxRa9hF4HAN4T6CByVLw6GgVtEaeC0Htcj9hB41AQV7Q/hHwQkdavl9vkqW+sn5
UfBtNDk7PjuyoB4nEKZryDepqCjvMQ6HDUVzGhdKww9CyKucYk40RkoFIAYGVf8E+E3H/4it
qFI4iBu3Pd9C7sy217FIV9xY5omV2uQU6LZASJRzqaOM/r2heQF6+0pUHF03cc6WMfrMr8OM
q291f9mdDbAbxXhIuXlJLZArjohyZ77JMryGskSrJCxglYXxkl7OMPGf4DQcC9yOz5euL76R
dldaPdeXu22xeqQt7J7vyLXribVFiNhveWKfH8T/cMC0/K7c6fTk2uuJCJ905IpUi9Uncu2o
tSeR20RmhNTJVZzMD3h4cp+bgdCQGExcJUmqc3Xwjh1PvgcX09F0bIEjXoI6vClWntMte7Zu
iGkmaprRYpPFCjG9y5AkSbczgz0gA03UbfQBsDvZPCxQL1gizEVQz8ffToAr5HN7hVZdmskM
Dg6ga4Cp/NzZgEOW1b9NVkW4lHOEx8qpj/Fq7ncHYJrMkNJqda02KsvvWJ4vlaXl6lHAb7bJ
TX5TeLvYfW3/inHI314pPi69maUuz7+1ZqXdx08q7fbztDsqJr9jxfya5qh5U6gOq/AbEicf
Fpp8npVw+KDDSWDIDcAMwERiMF9Df/SxhQ/sozaJb4hCPwBvPgFV8qxAEMIeApH6vuE0e56D
ELfYO03gcpK9AOoc0G8kJMdi8rEmkWTvCKK5oTqQ8WexS557cS1Wjs/2dNVizCT8OuW3mbGv
39i6UK3BOJXVzqCSkIgnOC4xUBma0G748jpV6qXG9pxty6m4Th8hXi3boNlUbo/1KePeiWtV
9Ulf3nbnDJVm+kqeu9gH6joVeoWjPGSlBRFqapWSGDwVFuztoQqkh/jhpAALtqYrGhVQKUod
sI8TrMXTUkGy/jiqG6rnAvwFM8eNUGTzJBl+5Ct+7/CSJVGvQhFOGj4JeCMLPYnR/y9vBN0M
7AoAAA==
--------------1C732C24407074E821B3A976--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
