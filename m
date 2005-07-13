Return-Path: <joern@wohnheim.fh-wedel.de>
Received: from moskovskaya.fh-wedel.de (mail.fh-wedel.de [213.39.232.198])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D865667C52
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Jul 2005 08:51:17 +1000 (EST)
Date: Thu, 14 Jul 2005 00:20:22 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Wolfgang Denk <wd@denx.de>
Message-ID: <20050713222022.GB9546@wohnheim.fh-wedel.de>
References: <20050713153231.GA17534@mail19d.g19.rapidsite.net>
	<20050713203409.B6B0C353A37@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20050713203409.B6B0C353A37@atlas.denx.de>
Cc: Russell McGuire <rmcguire@uwbt.com>, linuxppc-embedded@ozlabs.org
Subject: Re: linux and sram
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 13 July 2005 22:34:09 +0200, Wolfgang Denk wrote:
> In message <20050713153231.GA17534@mail19d.g19.rapidsite.net> you wrote:
> > 
> > If we are using U-boot and populate the CFG_SRAM_SIZE and CFG_SRAM_BASE
> > values, and makes sure this is passed into the kernel.
> > 
> > Does Linux 2.4.2x+ have any direct support for this? Is it just added into
> > the regular memory pool? Does it get used for specific tasks?
> 
> The standard Linux kernel knows nothing about SRAM.
> 
> > Or is this set aside for custom drivers?
> 
> Indeed. You need a driver to support SRAM.

Some people use slram/phram for that purpose.  It creates an mtd
(memory technology device) which can be translated into either a block
or a char device.  Quite sufficient for most uses.

Jörn

-- 
To announce that there must be no criticism of the President, or that we
are to stand by the President, right or wrong, is not only unpatriotic
and servile, but is morally treasonable to the American public.
-- Theodore Roosevelt, Kansas City Star, 1918
