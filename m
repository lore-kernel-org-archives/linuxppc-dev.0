Message-Id: <200002021244.VAA29722@mail.cc.tohoku.ac.jp>
MIME-Version: 1.0
Date: Wed, 02 Feb 2000 21:44:19 +0900
From: Kazunori Aoshima <aoshimak@mail.cc.tohoku.ac.jp>
To: linuxppc-workstation@lists.linuxppc.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: vga16fb, clgenfb cannot wake up on 2.2.14
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi there,

I make an kernel with framebuffer drivers, not modules.
I add vga16fb option and clgenfb option on config.
Compile through with no trouble, but cannot make FrameBuffer
active on boot.

I should add some options when boot up?
I tried like these.

video="vga16fb:640x480-60"
video="clgenfb:640x480"

I need some other options?
Or, something failed in compile?

Best regards.
----------------------
Kaz Aoshima = Editor of the PReP station
Material deveropment, Faculty of engineering,
Tohoku University, Japan
E-mail:aoshimak@mail.cc.tohoku.ac.jp
#I would appreciate if you could give me suggestions
 for my impolite English expressions.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
