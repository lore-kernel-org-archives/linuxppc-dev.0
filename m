Message-Id: <200003072129.WAA00353@piglet.grunz.lu>
Date: Tue, 7 Mar 2000 22:29:45 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: nvram access in 2.3.48?
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi list,

Another weiredity I've come across in my 2.3 crusade: /dev/nvram
doesn't seem to work anymore.

I've enabled nvram support under the char devices, but the device
doesn't seem to get included in the kernel image: kmod tries to load a
module for char-major-10-144 upon access, but it's not built as a
module...

Anybody experienced this, and wants to spare me a few hours chasing
that problem?

Thanks

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
