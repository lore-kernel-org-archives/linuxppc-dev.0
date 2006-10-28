Return-Path: <benh@kernel.crashing.org>
Subject: Re: Re: [PATCH] General CHRP/MPC5K2 platform support patch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicolas DET <nd@bplan-gmbh.de>
In-Reply-To: <200610281343.k9SDhTJm020310@post.webmailer.de>
References: <200610281343.k9SDhTJm020310@post.webmailer.de>
Content-Type: text/plain
Date: Sun, 29 Oct 2006 07:12:24 +1100
Message-Id: <1162066344.25682.126.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, sl@bplan-gmbh.de,
	sha@pengutronix.de, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > As I said before, NR_IRQ is a poor choice for the size of the revmap.
> > You should have a constant somewhere defining what is your max HW irq
> > number. and use that +1, or a hw irq count.
> 
> Done: 64

Even with a new numbering invloving the category in top bits and the bit
number in the bottom ?

Ben.
