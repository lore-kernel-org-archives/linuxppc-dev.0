Message-ID: <3A625423.E0F6C9AC@vacuumgenesis.com>
Date: Sun, 14 Jan 2001 17:36:35 -0800
From: Timothy Ritchey <tritchey@vacuumgenesis.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: kswapd Oops
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am running the the linuxppc_2_4 snapshot from 01/13/01, booting using
ppcboot on a custom 860T-based board with 64 MB of dram. I am getting
periodic Oops like:

 Oops: kernel access of bad area, sig: 11
NIP: C002C044 XER: 00000140 LR: C002C024 SP: C3FA3F10 REGS: c3fa3e60
TRAP: 0300
[snip][snip][snip]
Call backtrace:
C015A354 C002C298 C0004E8C

I can still access the shell though.

the call backtrace indicates this is occuring during kswapd. I am trying
to isolate the problem to figure out what needs fixing. Is this a
potential MMU problem, or could it be a problem with the swap setup. I
am not sure what needs to be done with regards to an initrd-based system
with respect to swap. It doesn't seem to me that it should even BE
swapping since there is no disk... :/

Any advice would be appreciated.

Cheers,
tim

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
