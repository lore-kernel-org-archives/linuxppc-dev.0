Message-ID: <382C58ED.C782DCBB@broadlink.com>
Date: Fri, 12 Nov 1999 10:14:05 -0800
From: Scott Wood <scott@broadlink.com>
MIME-Version: 1.0
To: bsimon@ctam.com.au
CC: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: LinuxEmbedded: minimal network system packages.
References: <382B4396.57669F9B@ctam.com.au> <382BC934.EB69AB6D@linuxembedded.com> <382BBE88.12C92D9C@ctam.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I need to know what packages I NEED and where to find the sources for
> them.  RedHat and Debian supply all the sources for the releases.  I
> have been to the LinuxPPC mirror and also found RPM sources.  I am
> currently looking at these these packages are put together by the
> vendors and they must get the sources from somewhere else.  eg. where is
> the orignal site for "mount" ?  I prefer to use a tarball than some
> proprietry distribution package.
> 

There is a utility in the Linux Router Project
(http://www.linuxrouter.org/)
called 'busybox' which contains many useful utilities and it's about 80k
(430k statically linked).  busybox can 'mount' but it just silently failed
on my MPC850 board, so I'm using 'mount' from util-linux-2.9.  If you're
using
a RedHat-based distribution, you can use 'rpm -qf </path/to/filename>' 
to find the name of the package that <filename> belongs to.  


> Thanks,
> Brendan Simon.

-- 
+---------------------+----------------------+
|     Scott Wood      |   Systems  Engineer  |
|=====================+======================|
|           BroadLink Communications         |
+--------------------------------------------+

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
