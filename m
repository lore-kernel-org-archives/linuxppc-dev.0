Date: Wed, 11 Oct 2000 23:01:18 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Josh Huber <huber@mclx.com>
cc: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dual head r128
In-Reply-To: <20001011141722.A1437@missioncriticallinux.com>
Message-ID: <Pine.HPX.4.10.10010112251120.16113-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 11 Oct 2000, Josh Huber wrote:

> Of note is the:
> c000:00b9: 63 ILLEGAL X86 OPCODE!
>
> line in x.log, when trying to run int10 on the secondary card.

Hmmm, 0x63 is the opcode for arpl, a protected mode only instruction which
is related to (shudder) segments and their protection model. If you reach
this code, it might be an emulator bug (but I gave up trying to understand
Xfree's emulator), but I can't remember (and I got rid of my XFree sources
because I needed the disk space for something else) if there is a way to
put a breakpoint in the emulated ROM and step (emulated) instruction by
instruction.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
