Date: Wed, 20 Jan 1999 12:09:34 +0100
From: massin@col.bsf.alcatel.fr (Raphael Massin)
Message-Id: <199901201109.MAA09311@c5s144.clb>
To: linuxppc-dev@lists.linuxppc.org
Subject: slight error in linux 2.2.0-pre8
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello all,

I downloaded yesterday the linux-2.2.0-pre8.tar.gz file and am adapting it
to my MPC860 based board.

In arch/ppc/boot/head.S, there is an error at line 157. It should be
'sub r7,r9,r8' and not 'sub r7,r8,r9'

	Raphael

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
