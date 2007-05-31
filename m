Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B1765DE00B
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Jun 2007 00:10:21 +1000 (EST)
Subject: RE: [PATCH 3/3] Modified quirk_mpc8641_transparent() to
	initializebridge resources.
From: Jon Loeliger <jdl@freescale.com>
To: Roy Zang <tie-fei.zang@freescale.com>
In-Reply-To: <7EA18FDD2DC2154AA3BD6D2F22A62A0E7EDA24@zch01exm23.fsl.freescale.net>
References: <1180463004.13106.65.camel@ld0161-tx32>
	<F962B8B4-32C0-46A6-B808-C18211353FCC@kernel.crashing.org>
	<7EA18FDD2DC2154AA3BD6D2F22A62A0E7EDA24@zch01exm23.fsl.freescale.net>
Content-Type: text/plain
Message-Id: <1180620613.1965.16.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Thu, 31 May 2007 09:10:13 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-05-31 at 01:48, Zang Roy-r61911 wrote:

> > Can this be merged with Zhang's "Set RC of mpc8641 to transparent  
> > bridge for transfer legacy I/O access." patch since it pretty much  
> > supersedes it.
> 
> I should be! 
> But why apply them sperately? 
> They refect differnet content and stage. For end user, they will only
> see the unified code :-).
> Roy

I have respun these two PCI-E patch sets into one and will post
them again.

jdl
