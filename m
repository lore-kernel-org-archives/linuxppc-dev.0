Date: Tue, 19 Jan 1999 11:47:38 +1100
Message-Id: <199901190047.LAA01101@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: Geert.Uytterhoeven@cs.kuleuven.ac.be
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: 
	<Pine.LNX.4.03.9901181803180.339-100000@mercator.cs.kuleuven.ac.be>
	(message from Geert Uytterhoeven on Mon, 18 Jan 1999 18:04:39 +0100
	(CET))
Subject: Re: MCLK=100 breaks PowerBook
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.LNX.4.03.9901181803180.339-100000@mercator.cs.kuleuven.ac.be>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be> wrote:

> On Mon, 18 Jan 1999, Cort Dougan wrote:
> > 0x0000 0x1fe2 0x0000 0x3fc3
> 
> Hmm, this would indicate mclk (GUI engine clock) runs at 8 MHz, and xclk
> (memory clock) runs at 16 MHz... very slow machine :-)

0x1fe2 == 8162, 0x3fc3 == 16323, so mclk = 81.62 MHz surely, not
8MHz??

Paul.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
