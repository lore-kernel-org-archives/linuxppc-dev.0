From: Alan Cox <alan@cymru.net>
Message-Id: <199812232158.VAA21083@snowcrash.cymru.net>
Subject: Re: TCPv4 checksum errors
To: Geert.Uytterhoeven@cs.kuleuven.ac.be (Geert Uytterhoeven)
Date: Wed, 23 Dec 1998 21:58:04 +0000 (GMT)
Cc: davem@dm.cobaltmicro.com, Paul.Mackerras@cs.anu.edu.au,
        linuxppc-dev@lists.linuxppc.org, linux-m68k@lists.linux-m68k.org,
        VANDROVE@vc.cvut.cz
In-Reply-To: <Pine.LNX.4.03.9812231013310.18310-100000@mercator.cs.kuleuven.ac.be> from "Geert Uytterhoeven" at Dec 23, 98 10:14:44 am
Content-Type: text
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The classic bad packet error is a frame that ends up with

checksum =FFFF end around carry left =1

because you need to do two end around carries

(FFFF        1)
(0000	     1)
(0001        0)

at the end of a checksum

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
