Message-Id: <200003071840.TAA03827@piglet.grunz.lu>
Date: Tue, 7 Mar 2000 19:40:58 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: controlfb in Paul's 2.3.48
To: linuxppc-dev@lists.linuxppc.org
cc: dan@debian.org
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi list,

I'm struggling with kernel 2.3 to get all my special stuff working
again...

Anyway, while experimenting, I noticed that the 2.3.48 controlfb
doesn't recognize my 4 MB VRAM anymore. Here's the message:

 controlfb: Memory bank 1 present, bank 2 absent, total VRAM 2MB

Sure enough, both banks are present and do work in 2.2.13 (my current
kernel).

Anybody else seen this? The controlfb VRAM detection thing has been
discussed all over a few times on the list, but I wasn't aware of any
remaining problems in the 2.2 version. So, why was it changed for 2.3?

Dan, did you have any other reports of misdetection? I can try and hack
a quick detection code, to see what goes on in my box...

Thanks

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
