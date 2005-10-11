Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3547B684C7
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Oct 2005 06:50:53 +1000 (EST)
Date: Tue, 11 Oct 2005 13:50:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nicolas DET <det.nicolas@free.fr>
Message-Id: <20051011135022.60ddfbbc.akpm@osdl.org>
In-Reply-To: <20050914091229.A27721C007F7@mwinf0309.wanadoo.fr>
References: <20050914091229.A27721C007F7@mwinf0309.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, sl@bplan-gmbh.de, dholm@gentoo.org
Subject: Re: SRAM support for the Pegasos II platform
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nicolas DET <det.nicolas@free.fr> wrote:
>
> You can find enclosed or at the URL a patch for the 2.6.14-rc1.
> http://arrakin.homedns.org/~nicolas/mv643xx_eth_chrp_pegasos_eth.c.2.6.14-rc1.diff
> 
> It allows (with drivers/net/mv643xx_eth.*) to take advantage of the SRAM of
> the Marvell Discovery II for the network driver.

I've kind of lost the plot with what happened with this patch.  Who is the
maintainer of this driver, and has [s]he commented on this patch?

The patch does strange things with whitespace: some places it uses spaces,
other places it uses tabs.  Please fix that up using hard tabs and resend. 
When doing so, please first review
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt for the patch
preparation protocol, thanks.
