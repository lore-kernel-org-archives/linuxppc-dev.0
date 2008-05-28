Return-Path: <linux@dominikbrodowski.net>
Received: from linta.de (isilmar.linta.de [213.133.102.198])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1CC98DDDD8
	for <linuxppc-dev@ozlabs.org>; Thu, 29 May 2008 08:35:38 +1000 (EST)
Date: Thu, 29 May 2008 00:28:54 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 07/12] pcmcia: use linux/of_{device,
	platform}.h instead of asm
Message-ID: <20080528222854.GA22248@isilmar.linta.de>
References: <20080523161627.a75d5010.sfr@canb.auug.org.au>
	<20080523163108.2762a15a.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080523163108.2762a15a.sfr@canb.auug.org.au>
Cc: Olof Johansson <olof@lixom.net>, ppc-dev <linuxppc-dev@ozlabs.org>,
	linux-pcmcia@lists.infradead.org, vbordug@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 23, 2008 at 04:31:08PM +1000, Stephen Rothwell wrote:
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>

I assume this is pushed upstream through -ppc?

Thanks,
	Dominik
