Message-ID: <36862FB3.17B2@post.uni-bielefeld.de>
Date: Sun, 27 Dec 1998 14:01:40 +0100
From: "Jens Ch. Restemeier" <jenschrr@post.uni-bielefeld.de>
Reply-To: jenschrr@post.uni-bielefeld.de
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: egcs bug  - who can I send it to ?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi !

I've got a problem compiling the latest snapshot of crystal space on
Linux/PPC. The same archive compiles on my 486 (after some small fixes).

The RPMS I installed didn't have a "mail me for bugs" address.

Is this a known bug ?

util/gfx/gifimage.cpp: In method `ImageGifFile::ImageGifFile(UByte *,
long int)':
util/gfx/gifimage.cpp:383: internal error--unrecognizable insn:
(insn 3958 3955 54 (set (mem:SI (plus:SI (reg:SI 18 r18)
                (const_int 65536)))
        (reg:SI 19 r19)) -1 (insn_list 3621 (insn_list 3955 (nil)))
    (nil))
toplev.c:1360: Internal compiler error in function fatal_insn
make[1]: *** [out/LINUX/X11_o/util/gfx/gifimage.o] Error 1
make: *** [cs] Error 2

Jens

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
