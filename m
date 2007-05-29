Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DF29DDE026
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 04:12:15 +1000 (EST)
Subject: Re: [PATCH 0/5] Add the support for MPC8641 silicon rev 2.0 and
	MPC8641HPCN board 2.0
From: Jon Loeliger <jdl@freescale.com>
To: Wei Zhang <Wei.Zhang@freescale.com>
In-Reply-To: <11798051102658-git-send-email-wei.zhang@freescale.com>
References: <11798051102658-git-send-email-wei.zhang@freescale.com>
Content-Type: text/plain
Message-Id: <1180462328.13106.29.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Tue, 29 May 2007 13:12:08 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-05-21 at 22:38, Zhang Wei wrote:
> Hi, Paul,
> 
> The below 5 patches add the support for MPC8641 rev 2.0 silicon and MPC8641HPCN board 2.0.
> 
>   [PATCH 1/5] Remove the errata fix codes for MPC8641 silicon ver 1.0 which is end of life.
>   [PATCH 2/5] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
>   [PATCH 3/5] Float the pci bus number on MPC8641HPCN board.
>   [PATCH 4/5] Set RC of mpc8641 to transparent bridge for transfer legacy I/O access.
>   [PATCH 5/5] Set IDE in ULI1575 to not native mode.
> 
> The MPC8641 rev 2.0 silicon fix the PCI/PCI-Express errata in rev 1.0. And the rev 1.0 silicon is end of life. So the dts tree and codes should be changes. Codes which are not compatible with PCI/PCI-Express specifications are removed. Some minor issues are fixed.
> 
> Thanks!
> 
> Best Regards,
> Zhang Wei

Paul,

I had earlier requested a "Hold" on this series of patches
until I was able to see it work on my system too.

I have now been able to  get working code here, but it
required a follow up set of 3 patches that I wrote.

So:  I will ACK these 5 from Zhang Wei, and then post
my 3 more patches.  If you would, please pick these up!

Thanks,
jdl
