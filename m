From: "Elan Feingold" <elan@nxnetworks.com>
To: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Most stable kernel?
Date: Mon, 6 Aug 2001 10:52:48 -0500
Message-ID: <NDBBLJKOJGKDOFBHNPGEAEGDCEAA.elan@nxnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

As mentioned in previous posts, we're using 8260 boards (EST currently, soon
to be custom) and we're using 2.4.5 + patches.  This kernel doesn't seem to
be completely stable, with kernel hangs when using strace and gdb.  I'm
interested in hearing what people out there consider to be a good stable
kernel to use (perhaps one of the stock HardHat kernels?).  Our only major
requirement is JFFS2, and we'd like to stick with the 2.4 series for their
fast networking.

Any insight would be much appreciated.

Best regards,

-elan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
