Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3DFA05C3.30703@ccrl.mot.com>
Date: Fri, 13 Dec 2002 10:07:31 -0600
From: "Steve Rossi" <Steve.Rossi@motorola.com>
MIME-Version: 1.0
To: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: 823 Video Controller Driver - where ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've seen some reference on the list regarding a driver for the 823
Video Controller -
i.e.
http://lists.linuxppc.org/results.html?restrict=linuxppc-embedded&words=vid823
however I've been unable to locate the source to vid823.c
apparently this question was asked before:
http://lists.linuxppc.org/linuxppc-embedded/200201/msg00164.html
and the answer was that its in the 2_4_devel tree, but I was unable to
find it in a recent snapshot of the tree (I'm unable to get the tree
from the bitkeeper repository due to a problem in bitkeeper 3.0 related
to http proxy with authentication - but thats another story!) so I got
the snapshot from http://ppckernel.org/tree.php?id=5
All I could find was the RPX framebuffer driver rpxfb.c for various LCD
panels using the LCD controller..
I'm looking for a driver for the video controller to output to an NTSC
encoder. Am I just missing something?
Anyone know where I can get vid823.c (or whatever it might be called
now) and whether its a true framebuffer driver?

Regards,
Steve

--
-------------------------------------------------------
Steven K. Rossi                     srossi@labs.mot.com
Principal Staff Engineer
Multimedia Communications Research Laboratory
Motorola Labs
-------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
