Date: Tue, 7 Dec 1999 20:19:37 +0200 (EET)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org,
        yellowdog-general@lists.yellowdoglinux.com,
        yellowdog-devel@lists.yellowdoglinux.com
Subject: X3.9.16 and kernel for Voodoo3
Message-ID: <Pine.LNX.4.20.9912072016210.583-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



  I've been working for that last few days to add support for my voodoo3 card
in fbdev and XFree3.9.16
I think that now both the fb and the X driver are in a condition good enough
for release (no accel in console yet but X are acceled).

For the Xserver you just need to install the rpm, don't forget to backup
your old /etx/X11/XF86Config file before installing the rpm.
The rpm will install a /etx/X11/XF86Config unfortunately since the format
has changed you want be able to use Xconfigurator Xautoconfig to edit it.
Also make sure that /etc/X11/X is a link to /usr/X11R6/bin/X

You can get the test Xserver and the kernel from:
ftp://idd-01.imbc.gr/pub/voodoo3/XFree3916-3.9.16-1.ppc.rpm
ftp://idd-01.imbc.gr/pub/voodoo3/vmlinux-991207.bz2

I'll post the kernel patches and the xfree srpms sometime tomorrow


 Thanks

Kostas Gewrgiou


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
