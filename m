Date: Tue, 26 Feb 2002 10:19:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: EP405 PCI interrupt mapping
Message-ID: <20020225231917.GD9850@zax>
References: <20020225014743.GD15788@zax> <3C7A8B4D.8050900@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3C7A8B4D.8050900@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Feb 25, 2002 at 11:06:53AM -0800, Matthew Locke wrote:
>
> David Gibson wrote:
>
> >Is the current PCI interrupt mapping stuff for the EP405
> >(i.e. ppc405_map_irq() in ep405.c) expected to work, or has it just
> >been copied from walnut and never updated for ep405?  It looks bogus
> >to me.
> >
>
> I just copied it from the walnut.  I didn't get that far. I was told you
> were going to make it all work;)

Fair enough.  I'll get onto that then shall I :-)

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
