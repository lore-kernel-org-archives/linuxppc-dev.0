From: kd@flaga.is
To: linuxppc-dev@lists.linuxppc.org
Message-ID: <002566DC.006770DB.00@notes.flaga.is>
Date: Wed, 16 Dec 1998 18:49:50 +0000
Subject: MPX860 : MBX_IMAP_ADDR undefined
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I am in the process of getting Linux to boot on Motorolla Evaluation board
for th 821 processor. But first I need
to compile the kernel. Unfortunately this fails on arch/ppc/kernel/irq.c
because of  MBX_IMAP_ADDR undefined
symbol error. I have done
find . -name "*.[ch]" -print -exec grep MBX_IMAP_ADDR \{\} \;
which reveals no definition of MBX_IMAP_ADDR symbol. It is only used in
several files.

I could not find patch that adds this symbol, so I wanted to ask if sombody
knows where to find a patch?

The kernel source i am trying to build is vanilla 2.1.131.

Thank you,

K.D.



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
