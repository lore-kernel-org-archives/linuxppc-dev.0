Message-ID: <638AA0336D7ED411928700D0B7B0D75B039D4E16@aimail.aiinet.com>
From: "Dayton, Dean" <deand@aiinet.com>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: dcache and 8260_io/fcc_enet.c
Date: Fri, 1 Nov 2002 10:30:10 -0500 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I noticed that fcc_enet_start_xmit() does not flush the transmit data before
setting up the transmit buffer descriptor. I get the impression that this is
not necessary. But I don't understand why. I have spent the morning looking
through code and Motorola docs and am non the wiser.

Thanks
Dean

-------------
Dean Dayton
System Architect - Applied Innovation Inc.
(614)923-1174
deand@aiinet.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
