Date: Mon, 31 Jul 2000 06:06:21 +0000 (UTC)
From: David Gatwood <dgatwood@mklinux.org>
To: mklinux-announce@public.lists.apple.com,
        mklinux-setup@public.lists.apple.com
cc: linuxppc-dev@lists.linuxppc.org, linuxppc-users@lists.linuxppc.org,
        port-macppc@netbsd.org, port-mac68k@netbsd.org
Subject: MKL-ANN: Performa 52xx/53xx/62xx/63xx Support
Message-ID: <Pine.LNX.3.96.1000731055118.16733A-100000@mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Apologies in advance for the cross-post.

As of July 31, 2000, the PowerMac 5200/5300/6200/6300 family of
computers, and their Performa equivalents, are officially
supported in MkLinux.  Please NOTE that only the 6214 has been
tested, so there may be some small snags in some of the others.
Barring any surprises, though, it should "just work".

CAVEATS:

      * Sound is not supported yet.  That's the next priority....

      * SCSI is working, but rather slow.  It's partially hardware
        at fault, and partially a lack of pseudo-DMA code.  Oh well.
        It "mostly works."  As always, your mileage may vary.

      * Serial is untested.  It should work, but again, YMMV.


Special Thanks:

      * Tony Mantler (of mac68k-land) for assistance in tracking down a
        lost IDE interrupt.

      * MontaVista Software for my continued employment.

      * Apple Computer for being about as unhelpful as one might expect,
        and for even releasing a perverse hybrid of a Quadra and a
        PowerMac in the first place ....

      * Linux-mac68k and NetBSD-mac68k for providing invaluable insight
        into the Quadra 630 upon which this beast was based, and more
        significantly, for correcting some of my own insights.

      * Everyone who has offered to help test this support, etc.  Now's
        your chance.

---

You can find a bleeding edge test kernel at

	ftp://ftp.mklinux.org/pub/contrib/Mach_Kernel.PERFORMA.gz

All source code changes have been incorporated into the official MkLinux
CVS tree.  For more information, please visit our web site at

	http://www.mklinux.org

Or visit our CVSweb system at

	http://cvs.mklinux.org/cgi-bin/cvsweb

For information on this port, feel free to contact me directly at this
email address.



Cheers,
David

-- dgatwood@mklinux.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
