Message-ID: <3E257AB5.8070405@intracom.gr>
Date: Wed, 15 Jan 2003 17:13:57 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: acurtis@onz.com
Cc: linuxppc-embedded@lists.linuxppc.org,
	Tom Rini <trini@kernel.crashing.org>,
	Dan Malek <dan@embeddededge.com>
Subject: Re: 2.5 and request_8xxirq
References: <NCBBIINEHIPFGJPLBEIFOEOGEAAA.acurtis@onz.com>
In-Reply-To: <NCBBIINEHIPFGJPLBEIFOEOGEAAA.acurtis@onz.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Allen Curtis wrote:

>Just use request_irq() instead....
>
Sure, could you please elaborate a little bit?

I'm asking because by looking at the posted patch,
while the replacement is straight-forward for
request_8xxirq -> request_irq, there is also
the replacement of cpm_install_handler with
request_irq.

AFAIK the replacement is something like this:

cpm_install_handler(irqno, handler, ...) ->
   request_irq(CPM_IRQ_OFFSET + irqno, handler, ...)

CPM_IRQ_OFFSET is nowhere to be found.

Could someone clear this up?

Thanks

>>I'm in the process of porting my board based on a MPC850
>>from 2.4 to 2.5 and it appears that request_8xxirq is gone.
>>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
