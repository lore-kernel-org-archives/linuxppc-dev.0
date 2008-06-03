Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 260FDDDF02
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 01:57:11 +1000 (EST)
Message-ID: <484569CB.9090104@freescale.com>
Date: Tue, 03 Jun 2008 10:56:59 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC] Make board force selection of PHYLIB
References: <Pine.LNX.4.64.0806021019540.22439@blarg.am.freescale.net>	<484419EE.5040503@garzik.org>	<1E4EB64C-0618-497E-AABC-74EB7D74B97F@kernel.crashing.org>	<48442239.7090906@garzik.org>	<BF15FEBB-4876-4B16-915B-1D21BF989DA8@kernel.crashing.org>	<83820D83-487C-4586-9867-F4226A87A276@freescale.com>	<48445851.4090105@garzik.org>	<095F258F-72DD-4F27-A457-A57D9FAA1E76@kernel.crashing.org>	<48448020.5020407@freescale.com>	<Pine.LNX.4.64.0806030945540.21537@blarg.am.freescale.net>	<48455EEA.3040909@freescale.com>	<57B740A4-A3E0-4D93-A5D9-77B14C6E9E92@kernel.crashing.org>	<484560C0.2080607@freescale.com>	<F70B6328-5DF2-4CCC-9AAF-DD49BDA267A5@kernel.crashing.org>	<484564EA.8050706@freescale.com>
	<F7DB0156-66BA-4E52-9CA6-F1405E3D31C6@kernel.crashing.org>
In-Reply-To: <F7DB0156-66BA-4E52-9CA6-F1405E3D31C6@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	Jeff Garzik <jeff@garzik.org>, adrian.bunk@movial.fi
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> I see.  However, I don't like the idea I have to build in the PHYLIB
> if I don't need it at all.

Understood, but in practice I don't think the 10K or so matters that
much on a typical 85xx board, and if the user really needs to trim
things down, they always have the option of manually ripping the phy
stuff out.

> It seems like the type of breakage you are talking about exists today
> all over the place.

It exists in a few places, but it's not that common, and often it's 
obvious what went wrong when the module won't load because some kernel 
hook didn't get built.  It's not a huge deal, but I'd rather avoid 
introducing another instance.

-Scott
