Date: Tue, 21 Oct 2003 16:03:33 +0200 (MEST)
From: Holger Bettag <hobold@informatik.uni-bremen.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: RE: Using in_8 and out_8 without module optimization
In-Reply-To: <3F710B1D000A0C08@mssbzhh-int.msg.bluewin.ch>
Message-ID: <Pine.GSO.4.53.0310211558320.16885@bob.informatik.uni-bremen.de>
References: <3F710B1D000A0C08@mssbzhh-int.msg.bluewin.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 21 Oct 2003, Wolfgang Grandegger wrote:

> To ensure that the asm-code is executed in sequence with your
> C-code use:
>
>   -fno-schedule-insns -fno-schedule-insns2
>
Some other optimizations might still rearrange code, so consider
-fno-strength-reduce and -fno-move-all-moveables and possibly a few other
switches. Just compile with -S and see if the assembly code looks right.

I think there is also a switch to force inline functions to be
instantiated, could be -fno-inline or -fforce-no-inline, but the former
solution is likely a lot better.

  Holger

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
