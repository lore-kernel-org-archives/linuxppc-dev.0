Message-ID: <397D926F.111AF60E@ivey.uwo.ca>
Date: Tue, 25 Jul 2000 09:13:19 -0400
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
MIME-Version: 1.0
To: Godmar Back <gback@cs.utah.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: diff to tonight's kaffe cvs tree to work on ppc
References: <200007250345.VAA22028@faith.cs.utah.edu>
Content-Type: multipart/mixed;
 boundary="------------46206385CBD87EC0A90B12E3"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------46206385CBD87EC0A90B12E3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Godmar,

> Is the stack alignment code 64bit safe?

As promised, here is the clean up patch.  It should be applied after my first
patch.

The only assumption I am making here is that sizeof(unsigned int) = sizeof(void
*).
This should be true on both 64 bit and 32 bit systems.

I have attached the patch.

Hope you will commit these changes to the official kaffe tree.

Thanks,

Kevin
--------------46206385CBD87EC0A90B12E3
Content-Type: application/x-gzip;
 name="kaffe_cleanups.patch.gz"
Content-Disposition: inline;
 filename="kaffe_cleanups.patch.gz"
Content-Transfer-Encoding: base64

H4sICDeRfTkAA2thZmZlX2NsZWFudXBzLnBhdGNoAJWSb2+bMBDGX4dPceukCkIcTP5sHdOm
pFlUrUvbaMk07c0QAxNowaAASfrte46BsCSTVksg+x4/d/b5RwiBJ8f3meEm3A9XRpps2Tp1
cRnHCe8GrbuEw20RQW8APdMa9qwBhR6lVNF1XVqJu8n+aV8WTNqHQD9YFO1DaR+NgAw6pgk6
/vswGikAbfEZCijkbeiDx/yQMw9U245CXuxsW4PLyyqM0bIYxhWyt3DUoNydoiBPYQcoStdZ
UT84q4wNrTaeaHBQ76fTL/ZiOZ58s8ezrzf3B6URVFMNQMVR8CxciZuFPNcwitcCc6jBbziV
FB32B3xVN0AY9mfKnjOPpRMniu5YHiSekLgbFR6DCxej8T5qYz+6wQWKMl3r2KZOxrOZBsdh
4ZOSQmqQGv9NbKAlZ3FmFDzckcc8WDPHy4xy0nVbi6LEqw/0yqJ9a/j+HF6vS9qE7gozWgLe
Cjqzb9KOSUGvJgK9VsxiN31WOdtmueM+dSCJvHImn3DyMP+lfcQWMe5hd402vJHCzfeHnwv7
x/yU3P8Ct4WZtgw4w7dNijXsi0KewB8GTiRhwJX5TuQnUI7qnPCpwYwbOGtoaw3AooSvNKhv
JUCjO18OirdpkqUeQyzYO1Nuk4QeVvmL7LpA3SBFx6Yupkt7MVcf89AjnxnfdKC5UWJaVRd7
r+ea8gJqfybdkgQAAA==
--------------46206385CBD87EC0A90B12E3--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
