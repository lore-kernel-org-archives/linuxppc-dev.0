Date: Sun, 18 Jun 2000 17:02:36 -0700 (PDT)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: ATI Mach64 support in XFree86 4.0 update...
Message-ID: <Pine.LNX.4.10.10006181702190.22994-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Since there have been many people asking about mach64 support int xfree
4.0 I figured I might as well give you all the status of the driver.

I am almost done with 'porting' the ATI driver to ppc and so far its
working quite well.  While I'm not completely finished with all the
acceleration, what is completed are:  ScreenToScreen blits, rect fills,
sold lines, and 8x8 mono pattern fills.

Unfortunately due to some binary driver incompatibilities between current
xfree86 cvs and Jack Howarth's 4.0-stock rpms, the driver seems to not
work with his rpms.  Luckily, the next xfree86 release is around the
corner so once that happens I will merge the driver and put up a
compatibile release.

For those interested in the driver's development, I will be placing info
and binary snapshots (xfree liscence prohibits me from releasing source),
at:

ftp://devel.linuxppc.org/users/ajoshi/xf4

Here you will find x11perf results comparison between the driver and
Xpmac, a bootlog of the driver, and some other various things i throw up
there.



ani


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
