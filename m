From: phandel@cise.ufl.edu
Date: Tue, 28 Mar 2000 14:01:47 -0500 (EST)
To: sabotage <kcz84@dial.pipex.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Voodoo 3 bug on 2.3.99pre3
In-Reply-To: <200003280946.DAA21846@lists.linuxppc.org>
Message-ID: <Pine.LNX.4.21.0003281359550.14912-100000@adsl-78-160-189.gnv.bellsouth.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 29 Mar 2000, sabotage wrote:

>  I have a voodoo 3 2000 PCI card on my UMAX s900 SMP and i was trying to get

You can try the _experimental_ kernel & XFree86 3.9.16 rpm from Kostas:

ftp://idd-01.imbc.gr/pub/voodoo3

NOTE: XFree86 4.0 REQUIRES a very different /etc/X11/XF86Config file from
XFree86 3.x.  I have some different XF86Config files at:

http://www.cise.ufl.edu/~phandel/linux/sample/

Also, you *may* need to change the BusID number based on what slot your
Voodoo3 is in (BusID "PCI:0:15:0" for me) if commenting it out doesn't
work.

3.9.16 runs well, although not as fast as 4.0.  I've put a comparison of
the Rage128-x86, TNT2, and Voodoo3 XF86 3.9.16 & 4.0 on my web page:

http://www.cise.ufl.edu/~phandel/linux/txt/r128_tnt2_v3.txt

I believe these were all done at 1024x768 16bpp.


Thanks,
Peter

[btw- you can also copy the tdfxfb.c from 2.3.x to a 2.2.14 tree and apply
Kostas' tdfxfb patch, which is what I'm running]


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
