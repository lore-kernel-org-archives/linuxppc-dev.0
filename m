From: "Elan Feingold" <elan@nxnetworks.com>
To: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Subject: CONFIG_SERIAL_CONSOLE question
Date: Fri, 24 Aug 2001 12:27:01 -0500
Message-ID: <NDBBLJKOJGKDOFBHNPGEKEIHCEAA.elan@nxnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm using Linux 2.4.4-2001-07-23, targetting a custom 860T board with FEC
based on BSEIP board.  It comes up fine, but when it goes to mount the NFS
root and start init, I invariably get a:

"Oops: kernel access of bad area, sig: 11"

Another message
(http://lists.linuxppc.org/linuxppc-embedded/200103/msg00025.html I read led
me to believe that this was caused by the CONFIG_SERIAL_CONSOLE.  When I
turn it off (which is hard, because config.in wants it on!) I simply get no
output and I can't really tell what's happening.

Any idea?

Best regards,

-elan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
