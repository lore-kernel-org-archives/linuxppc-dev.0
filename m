Date: Mon, 28 Dec 1998 19:41:14 -0700 (MST)
From: Jeff Rugen <jrugen@primenet.com>
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: PReP sound/sndvolmix
Message-ID: <Pine.BSI.3.96.981228193638.28639B-100000@usr02.primenet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Is sndvolmix supposed to work on PReP or only on Macs and similar?  I keep
getting a segmentation fault when I try to do the lwbrx on memory mapped
using mmap().  (Interestingly, stwbrx works fine).  Using the in_le32 and
out_le32 macros do the same thing).

If its not supposed to work on PReP, what's a good way to fix the sound
volume?  (I'm assuming that's the reason I'm not hearing sound at least).
If it is supposed to work, where can I find info on the awacs chip (I assume
that's what awacs.h is for and what the program is writing to)?

mmap() is mapping memory at AUD_CONT == ((unsigned *) 0xf3014000)

I'm using the 2.1.130 kernel from vger.

Thanks for any help/info.

----------------------------------------------------------------------------
Jeff Rugen                      jrugen@primenet.com

...Had this been an actual emergency, we would have fled in terror, and you 
would not have been informed.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
