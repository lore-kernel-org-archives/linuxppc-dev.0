Message-Id: <5.0.2.1.2.20040504164521.05116c10@bhawley.mailhost.luminex.com>
Date: Tue, 04 May 2004 16:50:58 -0700
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
From: Brian Hawley <bhawley@luminex.com>
Subject: Next steps
In-Reply-To: <20040504214623.49B32C109F@atlas.denx.de>
References: <Your message of "Tue, 04 May 2004 23:15:08 +0200." <20040504211508.GA2510@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We've finally gotten the 2.5 kernel to boot using u-boot [ 2.6.3 doesn't,
nor did 2.4 variants ] on a PPC440GP
on the Ebony board.

At this point, it is trying to talk to a dhcp/bootp server and get a NFS
root filesystem.

Eventually, we'll be porting this to a custom board with some other chip
set support on it.

Our application will essentially be data acquisition and
transmission.  We'll be talking to the chipset to
suck data off [ and push data ] and on the other side push/pull data from
the PCI bus.

Linux is probably overkill for this, but we wanted a development platform
we could extend in the future
more readily.

I'm curious as to the direction people think we should take at this
point.  Should we be trying to set up
a root NFS filesystem [ presumably because it is easier to change -- and
then moving it to an initrd ? ]?

What do we need on the NFS filesystem...

What resources can you point me to to help us make the transition to the
next level.

Any help is appreciated,

Thanks.

-- Brian

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
