From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "'Dan Malek'" <dan@embeddededge.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: SV: New invalidate/clean/flush_dcache functions
Date: Tue, 24 Dec 2002 11:36:15 +0100
Message-ID: <000001c2ab38$4b37edb0$73b9143e@hempc>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3E07715D.4030002@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Joakim Tjernlund wrote:
> >
> > How about adding new xxx_dcache_range() functions functions to PPC.
> > Below is my suggestion which is more logical and more efficient:
>
> These aren't any different from what we have, other than you give it
> a length instead of an ending address.  Someone has to do that
> arithmetic anyway, and you chose to do it inside of your new functions
> when a caller may already have it available.

I choose to let gcc do the arithmetic(and it's easier to understand for
A non assembler guy). Check the assembler output included last in my
mail.

> We also try to keep these
> functions common across multiple architectures, which is especially
> important to embedded systems that may share common devices connected
> to the processor bus.

OK, what are the other arch's that have these functions?

Merry X-mas
            Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
