From: "Stefano Coluccini" <s.coluccini@caen.it>
To: "Matt Porter" <mporter@mvista.com>
Cc: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>,
	"Gabriel Paubert" <paubert@iram.es>
Subject: RE: MVME5100: kernel hangs in dcache_init
Date: Fri, 16 Feb 2001 17:32:23 +0100
Message-ID: <NDBBIFIMCKPOADMAJOKMCEOGCOAA.s.coluccini@caen.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20010216090016.D20336@beef.az.mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> Ok, well, it was just a guess.  To be honest, I'd throw my Abatron on
> there at this point.  The alternative is a liberal sprinkling of
> printk's and/or kgdb unless somebody else has a strong clue as to the
> source of the problem.
>

 ... mmmhhh, I have not a commercial debugger and I have never used kgdb,
also, I've tried to compile the kernel with the kgdb support but it does not
finish the compilation. At the moment my unique debugging technique is
printk, do you think is necessary to setup kgdb ?
With printk, in this case, I don't understand what I can print because there
are not a lot of values to print. I suppose the problem is in the
initialization of MMU or IRQ and this problem is a side effect. For example,
in prep_setup.c there is a write to 8000081c to enable the L2 cache, but in
the MVME5100 programmers manual I haven't find the address of the
corresponding register so I'm not sure of the effect of this write.

>You might want to see the MCPN765 and PrPMC750 ports that are in
>in the 2_5 tree.  They're examples of what I'm working on with the
>2300/2400/2600/2700/3600/4600, MTX variants, and MCP(N)750.

Excuse me ... but where I can find that *VITAL* helps ?
Thank you very much.

Stefano.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
