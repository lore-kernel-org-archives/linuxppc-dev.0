MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <14798.43366.937709.900651@esb.bbn.com>
Date: Sun, 24 Sep 2000 21:24:54 -0400
From: R Shapiro <rshapiro@bbn.com>
To: Michel Dänzer <daenzerm@student.ethz.ch>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 with rage II/rage pro -- multi-headed display!
In-Reply-To: <39CE8B90.1B318DD2@student.ethz.ch>
References: <Pine.LNX.4.10.10009231028030.26749-100000@apollo.kulian.net>
	<14798.23332.833379.615321@esb.bbn.com>
	<39CE8B90.1B318DD2@student.ethz.ch>
Reply-To: rshapiro@bbn.com
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Dänzer writes:
 > What bug with screenblanking?

Using the fbdev driver with xf 4.0.1, the default screenblanker kills
the server as soon as the blanker is activated.  This can easily be
replicated via 'xset s activate' or by letting the screenblanker
activate itself by timing out. The ati driver and the r128 driver
don't have this problem, only fbdev.

I've seen this on all three platforms where I've tested 4.0.1, either
using Franz Sirl's rpms or using the version I built with sources
rsync'd yesterday.

Martin Costabel reported this back in July on the users list so I
assumed it was a known but low-priority bug (it's easily gotten around
via 'xset s noblank').




 > > I can't test xinerama on this platform because the three screen don't
 > > all run at same depth (two use depth 15/16, one uses depth 8).
 >
 > What about just testing it with the two heads who run at 16 bpp, or run all
 > heads in depth 8?

I won't have access to the machine for a few days: the multi screen X
will be used off and on for demos all week :) But I'll test this as
soon as I can fiddle with the config file again.

What's the right syntax for starting in this mode?  startx -- +xinerama ?



--
rshapiro@bbn.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
