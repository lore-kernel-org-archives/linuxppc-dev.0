Message-Id: <200108090601.IAA00745@piglet.grunz.lu>
Date: Thu, 9 Aug 2001 08:01:43 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: TiBook powers off on boot
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

Anybody seen this?

With BenH's latest tree (rsync from two or three days ago), my TiBook
powers off on boot. The last thing I see on display is the firewire
thing intializing; after that it just goes 'poof' and it's off.

Also, when this happens, it seems the hardware clock is reset. Next
boot, it's at 1904...

>From both descriptions I'd say soething scribbles over the PMU memory
area. Anybody know more?

Thanks

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
