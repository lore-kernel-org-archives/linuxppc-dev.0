Message-Id: <199902151023.LAA25674@kieray1>
Date: Mon, 15 Feb 1999 11:23:27 +0100 (MET)
From: Magnus Damm <eramdam@kieray1.p.y.ki.era.ericsson.se>
Reply-To: Magnus Damm <eramdam@kieray1.p.y.ki.era.ericsson.se>
Subject: FADS fec
To: dmalec@jlc.net
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Is there anyone out there that has successfully compiled and run the
"embedded-2_2p7_tar.gz" using fec.c on a FADS860T board?

My ethernet tranciever LXT970 powers up in a state that drives the IRQ2
pin low.

So linux drowns in interrupts.

"zImage.fads-2.1.127" from the embedded directory works great.

I guess that code initializes something that "embedded-2_2p7_tar.gz" doesn't.

Anyone with a clue?

Cheers /

magnus


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
