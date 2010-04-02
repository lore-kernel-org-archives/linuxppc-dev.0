Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 4D9FDB7CF4
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Apr 2010 06:47:21 +1100 (EST)
Date: Fri, 2 Apr 2010 15:47:18 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH RESEND 3/3] i2c/ibm-iic: drop NO_IRQ
Message-ID: <20100402154718.4976f2d9@lappy.seanm.ca>
In-Reply-To: <1270167421-5205-4-git-send-email-w.sang@pengutronix.de>
References: <1270167421-5205-1-git-send-email-w.sang@pengutronix.de>
	<1270167421-5205-4-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org,
	Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri,  2 Apr 2010 02:17:01 +0200
Wolfram Sang <w.sang@pengutronix.de> wrote:

> Drop NO_IRQ as 0 is the preferred way to describe 'no irq'
> (http://lkml.org/lkml/2005/11/21/221). This change is safe, as the
> driver is only used on powerpc, where NO_IRQ is 0 anyhow.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Sean MacLennan <smaclennan@pikatech.com>

Cheers,
   Sean
