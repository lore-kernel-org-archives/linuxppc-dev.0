Content-Type: text/plain;
  charset="us-ascii"
Date: Wed, 31 Jul 2002 15:50:02 +0200
From: Howard Gray <ppclist@matrix-vision.de>
Message-Id: <200207311550.02892.ppclist@matrix-vision.de>
MIME-Version: 1.0
Reply-To: howard.gray@matrix-vision.de
Subject: Re. Davicom DM9102A Network Problems
To: linuxppc-embedded@lists.linuxppc.org
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Howard Gray wrote....
>> How can the tulip driver work with the DM9102A at all if the transmit
>> buffers are not guaranteed to be correctly aligned ?

Answering one of my own questions.....

According to a chip errata sheet the DM9102A Rev. 0x40 requires double word
aligned transmit buffers but earlier revisions (e.g. 0x31) didn't. I guess
the tulip driver works well with older revisions only.

But my question still remains: How can I get a double word aligned transmit
buffer using the network core's sk_buff mechanism ? If I can't do that I'll
have to rewrite the driver to use use my own aligned buffers and copy the
sk_buff data to them. It's a pity because then it doesn't make much sense to
follow that with a DMA transfer....

--
Howard Gray
MATRIX Vision GmbH
Oppenweiler
Germany


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
