Date: Wed, 20 Jan 1999 23:58:04 -0800
Message-Id: <199901210758.XAA14846@dm.cobaltmicro.com>
From: "David S. Miller" <davem@dm.cobaltmicro.com>
To: Geert.Uytterhoeven@cs.kuleuven.ac.be
CC: davies@maniac.ultranet.com, becker@cesdis1.gsfc.nasa.gov,
        linux-kernel@vger.rutgers.edu, linuxppc-dev@lists.linuxppc.org
In-reply-to: 
	<Pine.LNX.4.03.9901202221410.28223-100000@mercator.cs.kuleuven.ac.be>
	(message from Geert Uytterhoeven on Wed, 20 Jan 1999 22:28:13 +0100
	(CET))
Subject: Re: de4x5 vs. tulip on PPC
References: <Pine.LNX.4.03.9901202221410.28223-100000@mercator.cs.kuleuven.ac.be>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


   Date: 	Wed, 20 Jan 1999 22:28:13 +0100 (CET)
   From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>

   On my machine, de4x5.c works, while tulip.c doesn't.

   Machine is a CHRP/PPC box, Ethernet is 21041 based D-Link DE-530CT.

 ...

   So at least the Ethernet HW address is in the wrong endiannes for tulip.c.

   Are there people who can use tulip.c on a big endian machine?

Nope, I gave up a long time ago using anything other than de4x5.c on
sparc machines. 

Later,
David S. Miller
davem@dm.cobaltmicro.com

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
