Date: Wed, 7 Nov 01 13:22:09 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0111072122.AA06299@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: RFC: i8259.c cleanup
Cc: Sven.Dickert@planb.de, davidm@amberdata.demon.co.uk,
	hollis@austin.ibm.com, paubert@iram.es
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hollis@austin.ibm.com wrote:

> Would you say poking the 8259 directly is more "right" than using 0xbffffff0
> (or equivalent)?

Both methods are equally right. However, the polling method requires knowledge
only of the 8259s, which is required anyway, while the other method requires
knowledge of the interrupt acknowledge mechanism. It is also possible for
somebody to design a machine with 8259s without any interrupt acknowledge
mechanism at all, the 8259 datasheet will tell you that it has been designed
for such applications as well.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
