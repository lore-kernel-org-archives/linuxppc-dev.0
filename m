Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id D997BDDE11
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 03:47:22 +1000 (EST)
Subject: Re: [PATCH 0/5] Add the support for MPC8641 silicon rev 2.0 and
	MPC8641HPCN board 2.0
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Zhang Wei <wei.zhang@freescale.com>
In-Reply-To: <11798051102658-git-send-email-wei.zhang@freescale.com>
References: <11798051102658-git-send-email-wei.zhang@freescale.com>
Content-Type: text/plain
Date: Tue, 22 May 2007 10:47:19 -0700
Message-Id: <1179856039.27985.17.camel@rhino>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-22 at 11:38 +0800, Zhang Wei wrote:
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
> 

I can't get your patches to apply to Paulus' tree.  Which tree are these
against?

--Wade
