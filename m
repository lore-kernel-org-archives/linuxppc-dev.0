From: Arno Griffioen <arno@usn.nl>
Message-Id: <199812221013.LAA23494@superluminal.usn.nl>
Subject: Re: TCPv4 checksum errors
To: Geert.Uytterhoeven@cs.kuleuven.ac.be (Geert Uytterhoeven)
Date: Tue, 22 Dec 1998 11:13:26 +0100 (MET)
Cc: davem@dm.cobaltmicro.com, Paul.Mackerras@cs.anu.edu.au,
        linuxppc-dev@lists.linuxppc.org, linux-m68k@lists.linux-m68k.org
In-Reply-To: <Pine.LNX.4.03.9812221039490.5727-100000@mercator.cs.kuleuven.ac.be> from "Geert Uytterhoeven" at Dec 22, 98 11:01:13 am
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > BTW, do all of the PPC's which exhibit the behavior use the same
> > ethernet controller?
> 
> Yes, we all have Tulip boards (I think >95% of the PPC users have Tulip
> boards). And the message on linux-kernel about checksum errors on ARM related
> to Tulip made me suspicious at well...

Suggestion: 

Perhaps you should try some tests with an Amiga/PPC machine. That definitely
doesn't use the Tulip board, but is PPC based. Can't help you there yet
though as Linux/PPC dies with a machine-check when I try to access 
the brain-dead ISA NE2000 in my machine.

Should give some clue about either the PPC checksum-computation or
the ethernet card doing 'nasty things'.

								Bye Arno.

-- 
Internet Exchange Europe B.V.Fax: +31-70-3630470 | One disk to rule them all,
Lange Voorhout 9             Tel: +31-70-3600379 | One disk to bind them,
2514EA Den Haag +--------------------------------+ One disk to hold the files
The Netherlands |   * END OF TRANSMISSION *      | And in the darkness grind 'em
----------------+--------------------------------+------------------------------

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
