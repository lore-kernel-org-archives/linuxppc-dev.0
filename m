Message-ID: <3C67B551.75074F10@ardistech.com>
Date: Mon, 11 Feb 2002 13:13:05 +0100
From: "bart@ardistech.com" <bart@ardistech.com>
Reply-To: bart@ardistech.com
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
Cc: Alex Zeffertt <ajz@cambridgebroadband.com>,
	Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC823: i2c-algo-8xx read interrupt?
References: <3C63EC39.ACEECA08@ardistech.com> <3C640532.5000708@embeddededge.com> <3C640C11.4080407@cambridgebroadband.com> <3C6410F1.4000104@embeddededge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> > .....  Alternatively, turn off the TX
> > interrupt and use the RX interrupt instead....
>
I turned of the TX interrupt and used the RX interrupt, and this very often works :(
But not always. Approx. one out of 300 reads (reading one byte off a I2C expander chip)
the RX interrupt gets 'lost' (in the CPM?). Maybe the distance in time between the RX
and TX internal interrupt flags get to close and one of them wins? Or something like
Wolgang Denk found in RISC timers overwriting port B data register, but now parts
of the RISC software competing for the I2CER?

Anyway, I now use the TX interrupt again because the RX is not reliable.

	Bart

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
