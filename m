Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 72D65DE4CC
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jun 2008 02:08:47 +1000 (EST)
Subject: Re: Default flats for running dtc from kernel build
From: Jon Loeliger <jdl@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <0E974259-7988-4E3F-81F6-3FDEA01BAC9A@kernel.crashing.org>
References: <20080606143347.B35CC247FE@gemini.denx.de>
	<A005B9E2-9A1D-4190-AB00-A7C880E4DBDB@kernel.crashing.org>
	<1212766264.6788.4.camel@ld0161-tx32>
	<0E974259-7988-4E3F-81F6-3FDEA01BAC9A@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 06 Jun 2008 11:08:39 -0500
Message-Id: <1212768519.6788.14.camel@ld0161-tx32>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-06-06 at 10:42 -0500, Kumar Gala wrote:

> So maybe:
> 
> DTS_FLAGS	?= -P 0x1000

Lowercase "p".

> 1k seems like more than enough default padding.

I would think so.

> - k

jdl
