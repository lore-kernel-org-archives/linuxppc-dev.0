Date: Fri, 6 Dec 2002 11:29:01 -0700
From: Matt Porter <porter@cox.net>
To: Dan Malek <dan@embeddededge.com>
Cc: Matt Porter <porter@cox.net>,
	Joakim Tjernlund <joakim.tjernlund@lumentis.se>,
	Pantelis Antoniou <panto@intracom.gr>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Regarding consistent_alloc
Message-ID: <20021206112901.A18257@home.com>
References: <3DF0A4D9.4030603@intracom.gr> <IGEFJKJNHJDCBKALBJLLCEJFFIAA.joakim.tjernlund@lumentis.se> <20021206085909.B17918@home.com> <3DF0D6B6.2050307@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3DF0D6B6.2050307@embeddededge.com>; from dan@embeddededge.com on Fri, Dec 06, 2002 at 11:56:22AM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Dec 06, 2002 at 11:56:22AM -0500, Dan Malek wrote:
> Matt Porter wrote:
>
>  > ....  If you
> > want the kernel virtual address then you can apply __va to that.
>
> Errr....no, you can't.  That would give you the cached mapping.
> You need to hang on to both the dma_handle (the phys address token)
> and the virtual address returned by the function.  That's why both
> are returned.

That's what I said...but you clipped it out.  Once again,
consistent_alloc provides the caller everything they need.
An uncached mapping, a phys address, and from that you can use
__va() to get the cached mapping.

Seemed clear enough to me the first time.  My definition of a
"kernel virtual address" is the lowmem cached mapping.  If
I meant the uncached mapping I would have said it was a "kernel
vmalloc address" or something. :)

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
