Message-ID: <3EE6CADC.4060608@freenet.de>
Date: Wed, 11 Jun 2003 08:23:24 +0200
From: Markus Bernauer <markus.bernauer@freenet.de>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: telnetd: all network ports in use  -Solution-
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

I had, as several others too, the following problem:
When mounting the root-filesystem via nfs, I could not
telnet anymore to my target board. Telnet client always
gave me the error message: "telnetd: all network ports in
use". The ttyp*-devices were present and had the correct
permissions as I use the ELDK.
The simple solution was just to add the no_root_squash
parameter to the exports file of my nfs-server and
everything just worked fine.

Hope this will help.

Greetings

Markus


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
