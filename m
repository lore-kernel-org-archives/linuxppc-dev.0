Message-ID: <3C7A8B4D.8050900@mvista.com>
Date: Mon, 25 Feb 2002 11:06:53 -0800
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: EP405 PCI interrupt mapping
References: <20020225014743.GD15788@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:

>Is the current PCI interrupt mapping stuff for the EP405
>(i.e. ppc405_map_irq() in ep405.c) expected to work, or has it just
>been copied from walnut and never updated for ep405?  It looks bogus
>to me.
>

I just copied it from the walnut.  I didn't get that far. I was told you
were going to make it all work;)

>
>--
>David Gibson			| For every complex problem there is a
>david@gibson.dropbear.id.au	| solution which is simple, neat and
>				| wrong.  -- H.L. Mencken
>http://www.ozlabs.org/people/dgibson
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
