Date: Wed, 23 Dec 1998 23:36:53 -0800
Message-Id: <199812240736.XAA06955@dm.cobaltmicro.com>
From: "David S. Miller" <davem@dm.cobaltmicro.com>
To: alan@cymru.net
CC: Geert.Uytterhoeven@cs.kuleuven.ac.be, Paul.Mackerras@cs.anu.edu.au,
        linuxppc-dev@lists.linuxppc.org, linux-m68k@lists.linux-m68k.org,
        VANDROVE@vc.cvut.cz
In-reply-to: <199812232158.VAA21083@snowcrash.cymru.net> (message from Alan
	Cox on Wed, 23 Dec 1998 21:58:04 +0000 (GMT))
Subject: Re: TCPv4 checksum errors
References: <199812232158.VAA21083@snowcrash.cymru.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


   From: Alan Cox <alan@cymru.net>
   Date: Wed, 23 Dec 1998 21:58:04 +0000 (GMT)

   The classic bad packet error is a frame that ends up with

   checksum =FFFF end around carry left =1

I challenge you to generate a packet which will create this condition,
it is impossible as far as I have tried....

However, I'm very very interested in being proved wrong.  Because if I
am, then every single checksum implementation in the kernel would need
to be fixed and we should therefore settle this asap.

Instead of tiring one's brain like I did, to find if the case even
exists, better would probably be to put a piece of debugging code
which checked for this condition and printed out a nice message and
dumped the packet contents when triggered.

Later,
David S. Miller
davem@dm.cobaltmicro.com

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
