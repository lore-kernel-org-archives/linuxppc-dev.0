Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 13B3CDDE26
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 13:55:34 +1000 (EST)
In-Reply-To: <11798051102658-git-send-email-wei.zhang@freescale.com>
References: <11798051102658-git-send-email-wei.zhang@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B9B280B9-3F66-479B-ABB2-FD294EC25C7E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 0/5] Add the support for MPC8641 silicon rev 2.0 and
	MPC8641HPCN board 2.0
Date: Mon, 21 May 2007 22:53:49 -0500
To: Zhang Wei <wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 21, 2007, at 10:38 PM, Zhang Wei wrote:

> Hi, Paul,
>
> The below 5 patches add the support for MPC8641 rev 2.0 silicon and  
> MPC8641HPCN board 2.0.
>
>   [PATCH 1/5] Remove the errata fix codes for MPC8641 silicon ver  
> 1.0 which is end of life.
>   [PATCH 2/5] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
>   [PATCH 3/5] Float the pci bus number on MPC8641HPCN board.
>   [PATCH 4/5] Set RC of mpc8641 to transparent bridge for transfer  
> legacy I/O access.
>   [PATCH 5/5] Set IDE in ULI1575 to not native mode.
>
> The MPC8641 rev 2.0 silicon fix the PCI/PCI-Express errata in rev  
> 1.0. And the rev 1.0 silicon is end of life. So the dts tree and  
> codes should be changes. Codes which are not compatible with PCI/ 
> PCI-Express specifications are removed. Some minor issues are fixed.

How do these patches differ/interace from what Wade posted a few days  
ago?

Also, please CC me on future Freescale related patches.

- k
