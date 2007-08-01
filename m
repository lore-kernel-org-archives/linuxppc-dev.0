Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AB3FEDDDD8
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Aug 2007 04:36:26 +1000 (EST)
Date: Wed, 1 Aug 2007 13:36:16 -0500
From: Scott Wood <scottwood@freescale.com>
To: Yoni Levin <yoni.l@slyde-tech.com>
Subject: Re: GPIO interrupts on mpc8313e
Message-ID: <20070801183616.GA24549@ld0162-tx32.am.freescale.net>
References: <2C4FDB8D627248AE9B24BC21747E0F5D.MAI@mail.livedns.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2C4FDB8D627248AE9B24BC21747E0F5D.MAI@mail.livedns.co.il>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Aug 01, 2007 at 02:45:05PM +0300, Yoni Levin wrote:
> request_irq(74,handler,IRQF_DISABLED,"GPIO",NULL);
                         ^^^^^^^^^^^^^

Did you try removing that flag (or calling enable_irq())?

-Scott
