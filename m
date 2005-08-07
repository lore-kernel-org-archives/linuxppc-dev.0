Return-Path: <aris@cathedrallabs.org>
Received: from panda.sul.com.br (panda.sul.com.br [200.219.150.4])
	by ozlabs.org (Postfix) with ESMTP id 3E16867F1E
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  8 Aug 2005 01:44:35 +1000 (EST)
Date: Sun, 7 Aug 2005 12:44:32 -0300
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050807154432.GE5210@cathedrallabs.org>
References: <20050806180353.GW5210@cathedrallabs.org>
	<20050806232701.GD1099@dmt.cnet>
	<e5caa80a2cd721a4f6ee3c74ead906b2@embeddededge.com>
	<20050807043110.GA6316@dmt.cnet>
	<09b0792f426f1d5883cf5d437723f075@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <09b0792f426f1d5883cf5d437723f075@embeddededge.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] 8xx: add cpm_get_cpmp()
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> It depends how you define the semantics of this function call.
> Can you call it any (and all of the) time you need it, or does it
> actually perform an ioremap() and you only want to call it
> once?
what about don't cache it and call ioremap() from driver? (I guess
ioremap() already check if an area is already mapped, no?)

--
Aristeu
