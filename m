Message-ID: <3DFA1005.4020107@bluewin.ch>
Date: Fri, 13 Dec 2002 17:51:17 +0100
From: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
MIME-Version: 1.0
To: Steve Rossi <Steve.Rossi@motorola.com>
Cc: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 823 Video Controller Driver - where ?
References: <3DFA05C3.30703@ccrl.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 12/13/2002 05:07 PM Steve Rossi wrote:
> I've seen some reference on the list regarding a driver for the 823
> Video Controller -
> i.e.
> http://lists.linuxppc.org/results.html?restrict=linuxppc-embedded&words=vid823
> however I've been unable to locate the source to vid823.c
> apparently this question was asked before:
> http://lists.linuxppc.org/linuxppc-embedded/200201/msg00164.html
> and the answer was that its in the 2_4_devel tree, but I was unable to
> find it in a recent snapshot of the tree (I'm unable to get the tree
> from the bitkeeper repository due to a problem in bitkeeper 3.0 related
> to http proxy with authentication - but thats another story!) so I got
> the snapshot from http://ppckernel.org/tree.php?id=5
> All I could find was the RPX framebuffer driver rpxfb.c for various LCD
> panels using the LCD controller..
> I'm looking for a driver for the video controller to output to an NTSC
> encoder. Am I just missing something?
> Anyone know where I can get vid823.c (or whatever it might be called
> now) and whether its a true framebuffer driver?

Recently we have ported a video driver to the MPC823 using the video
encoder AD7176. The problem is, that the pixels data in the framebuffer
must have the YUV or Y-Cb-Y-Cr-Format which is rarely used, at least I
have not found any support in Linux or Microwindows. You can find the
port on our linux-2.4 CVS tree (see http://www.denx.de/re/linux.html).
Check for "arch/ppc_8xx/video823.c" and "drivers/video/fbcon-yuv.c".

Hope it helps,

Wolfgang.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
