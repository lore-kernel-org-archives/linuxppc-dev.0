Date: Tue, 30 May 2000 10:03:15 +0200 (CEST)
From: Geir Frode Raanes <geirfrs@invalid.ed.ntnu.no>
To: Neil Russell <caret@c-side.com>
cc: zzh <david-1z@263.net>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Floating point in 8260
In-Reply-To: <20000529234501.A10933@lx.c-side.com>
Message-ID: <Pine.BSF.4.21.0005300954100.44658-100000@invalid.ed.ntnu.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 29 May 2000, Neil Russell wrote:

> As I understand it, there is no production 8260 without an FPU.  Current
> production chips are rev A.1 which have an FPU, and new production are rev B
> which will also have an FPU.  You probably have no choice for production, so
> you should upgrade your test board if it has old an CPU.

I suppose I can tell since currently shipping 8260 come with FPU.
Early 8260 are just like the early 486SX - it does contain a FPU,
but it is disabled. But unlike the 486SX the 8260 FPU can be
reenabeled by some microcode patch - wich I do not have myself.
This is as much I know of this. If you are really nice to
Motorola then perhaps they will let you have this patch.

> > Should i recompile the bash and c lib.How should i treat
> > float point.BTW,i have a apple G3,should i compile
> > these stuff on this machine?

configure & make xgcc -nfp?
Then recompile GLibC (with soft float) I suppose.

--
  ******************************************************
  Never ever underestimate the power of human stupidity.
  -Robert Anson Heinlein

		GeirFRS@invalid.and.so.forth
  ******************************************************


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
