Message-Id: <200107080655.IAA00892@piglet.grunz.lu>
Date: Sun, 8 Jul 2001 08:55:22 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: IBM Microdrive PCCard on TiBook (ide-cs module)
To: iweiny@acm.org
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3B460601.6A3AA7D9@acm.org>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   6 Jul, this message from Ira Weiny echoed through cyberspace:
> 3) I have found that the io_base addresses is 0x1000 (as set in my
> config.opts file) and this is what is passed to the ide_register
> function.  Changing this address does not seem to change it's behavior
> though.  (??)

Here's what I have in config.opts on my TiBook:

include port 0x1000-0x10ff, port 0x1400-0x14ff
include memory 0x80400000-0x807ff000, memory 0xf3000000-0xf33ff000

This seems to work well; a modem card gets ports at 0x1000 and dos work
OK...

Note however that IDE on PowerMacs is a bit of a mess; things like you
need PowerMac built-in IDE support compiled in to get an IDE add-on
board working even though the box in questions doesn't have any built-in
IDE...

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
