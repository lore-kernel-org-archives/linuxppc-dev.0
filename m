Message-ID: <003501c43360$1b3e20f0$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: <bhawley@luminex.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Next steps
Date: Thu, 6 May 2004 07:48:50 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Bob,

I would definitely recommend NFS.  As Bob White pointed out, you can get a
directory structure all set up from eldk.  The thing about NFS is you have a
PC with visual tools and all to mess with the same files that your embedded
system is accessing.  Plus of course you have much more file space.  And if
you're new to Linux it's a whole lot easier to get up to speed on the PC.

dhcp & bootp are really different things from NFS, although I think you have
to enable them in the [embedded] kernel for nfsboot to work.  But you
probably want to set your board up with a fixed IP and compressed kernel (or
tftp it in) from u-boot, just feeding a command line to the kernel that
tells it the root is nfs something.  No sense adding more complexity than
you need!

When it comes to stand-alone booting of an embedded system you can also
consider jffs2 or cramfs instead of initrd.  (I can tell you more if you're
interested).

Mark Chambers
WV Computronics


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
