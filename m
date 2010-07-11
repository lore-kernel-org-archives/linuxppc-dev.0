Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6A0F1B6F19
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jul 2010 02:07:19 +1000 (EST)
Subject: Re: [PATCH 1/3] powerpc/cpm: Reintroduce global spi_pram struct
	(fixes build issue)
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100708171610.GA11621@oksana.dev.rtsoft.ru>
Date: Sun, 11 Jul 2010 11:07:01 -0500
Message-Id: <F42B140B-59CE-4851-A59C-7C0E401F9295@kernel.crashing.org>
References: <20100708171610.GA11621@oksana.dev.rtsoft.ru>
To: Anton Vorontsov <avorontsov@mvista.com>
Cc: LEROY Christophe <christophe.leroy@c-s.fr>, linuxppc-dev@ozlabs.org,
	Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 8, 2010, at 12:16 PM, Anton Vorontsov wrote:

> spi_t was removed in commit 644b2a680ccc51a9ec4d6beb12e9d47d2dee98e2
> ("powerpc/cpm: Remove SPI defines and spi structs"), the commit =
assumed
> that spi_t isn't used anywhere outside of the spi_mpc8xxx driver. But
> it appears that the struct is needed for micropatch code. So, let's
> reintroduce the struct.
>=20
> Fixes the following build issue:
>=20
>    CC      arch/powerpc/sysdev/micropatch.o
>  micropatch.c: In function 'cpm_load_patch':
>  micropatch.c:629: error: expected '=3D', ',', ';', 'asm' or =
'__attribute__' before '*' token
>  micropatch.c:629: error: 'spp' undeclared (first use in this =
function)
>  micropatch.c:629: error: (Each undeclared identifier is reported only =
once
>  micropatch.c:629: error: for each function it appears in.)
>=20
> Reported-by: LEROY Christophe <christophe.leroy@c-s.fr>
> Reported-by: Tony Breeds <tony@bakeyournoodle.com>
> Cc: <stable@kernel.org> [ .33, .34 ]
> Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
> ---

applied to merge

- k=
