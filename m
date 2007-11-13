Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BB3C0DDE3B
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 04:00:54 +1100 (EST)
Subject: Re: [PATCH] cell: Convert #include of asm/of_{platform, device}.h
	into linux/of_{platform, device}.h.
From: Jon Loeliger <jdl@freescale.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20071113120224.de390904.sfr@canb.auug.org.au>
References: <1194899211.3396.15.camel@ld0161-tx32>
	<20071113120224.de390904.sfr@canb.auug.org.au>
Content-Type: text/plain
Message-Id: <1194973242.12888.9.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Tue, 13 Nov 2007 11:00:42 -0600
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-11-12 at 19:02, Stephen Rothwell wrote:
> Hi Jon,
> 
> Thanks for this.
> 
> On Mon, 12 Nov 2007 14:26:51 -0600 Jon Loeliger <jdl@freescale.com> wrote:
> >
> > From: Jon Loeliger <jdl@freescale.com>
> > 
> > Signed-off-by: Jon Loeliger <jdl@freescale.com>
> 
> Acked-by: Stephen Rothwell <sfr@canb.auug.org.au> Built a ppc64_defconfig

Feh.  I'll respin this particular patch to 
include the platforms/celleb pair of files too.

Sorry,
jdl
