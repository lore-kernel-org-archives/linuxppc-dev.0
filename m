Date: Mon, 16 Dec 2002 12:58:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Todd Poynor <tpoynor@mvista.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Support for Arctic platform (405LP based)
Message-ID: <20021216015853.GG4981@zax.zax>
References: <20021213043628.GI21319@zax.zax> <3DFA3420.10105@mvista.com> <20021215073549.GB16755@zax.zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021215073549.GB16755@zax.zax>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sun, Dec 15, 2002 at 06:35:49PM +1100, David Gibson wrote:
> > CONFIG_IBM_OPENBIOS is taken out of the CONFIG_SYCAMORE section of
> > arch/ppc/config.in?
>
> Err... I have no idea what you're asking.  How did SYCAMORE get into
> this?
>
> > Duplication of the CONFIG_BEECH case in
> > arch/ppc/boot/simple/embed_config.c: might be trying to enable the SSX
> > bootloader for Beech, but since CONFIG_IBM_OPENBIOS is on for Beech it
> > seems we'd have dup definitions?  Would more SSX code would be necessary
> > anyhow?
>
> Again, I'm afraid I'm having trouble parsing that paragraph - what do
> you want to know?

Gah, ok, now I see what you're talking about:  the diffs to the
SYCMORE config and the extra beech code in my patch.  Yes, as you
probably suspected they were just mistakes - now corrected.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
