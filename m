Date: Mon, 23 Jul 2001 01:54:38 +0100
Subject: BK 2.4.7-pre8 & XF4.1.99.1 & IMSTT
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Cc: Ani Joshi <ajoshi@shell.unixbox.com>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010723010847.85BFC2F1AF@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I finally  built the XFree86 TOT (I had two bad files in the ati directory
which confused me for a day ... ).

using BK 2.4.7-pre8

It works fine on 9600/233 with imstt

The root window now works properly (i.e. displays the RedHat logo and the
kde login manager icon).

[it also seems fine on my g3/beige with ati/mach64]

-----

There is one issue in the 4.x releases that is confusing me (it may be a
distro or install problem).

it seems that /etc/X11/xdm/Xsession has lost (or isn't supplied with) the
normal user's PATH.  As a consequence it can't find kde (although it seems
to be able to find gnome).

At the moment I've fixed this in my installs by adding /opt/kde2/bin into
the PATH in Xsession ... but I guess this is not right.

Any pointers to how/where the PATH is inherited by xdm would be appreciated.

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
