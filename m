To: Alan Cox <alan@cymru.net>
Cc: Geert.Uytterhoeven@cs.kuleuven.ac.be (Geert Uytterhoeven),
        davem@dm.cobaltmicro.com, Paul.Mackerras@cs.anu.edu.au,
        linuxppc-dev@lists.linuxppc.org, linux-m68k@lists.linux-m68k.org,
        VANDROVE@vc.cvut.cz
Subject: Re: TCPv4 checksum errors
References: <199812232158.VAA21083@snowcrash.cymru.net>
From: Andreas Schwab <schwab@issan.informatik.uni-dortmund.de>
Date: 28 Dec 1998 10:20:34 +0100
In-Reply-To: Alan Cox's message of "Wed, 23 Dec 1998 21:58:04 +0000 (GMT)"
Message-Id: <vyzr9tky659.fsf@issan.cs.uni-dortmund.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Alan Cox <alan@cymru.net> writes:

|> The classic bad packet error is a frame that ends up with
|> 
|> checksum =FFFF end around carry left =1

There can never be a carry if the sum is FFFF.  A sum of two 16 bit values
is never be bigger than 1FFFE.

Andreas.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
