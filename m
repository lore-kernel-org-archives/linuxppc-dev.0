Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C5B84DDEDA
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 07:56:57 +1100 (EST)
Message-Id: <8E33B4C2-F1E3-4C64-86E4-6EAA4C7151C5@freescale.com>
From: Andy Fleming <afleming@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1231275171-21388-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] gianfar: ensure ECNTRL[R100] is cleared on link state
	change
Date: Tue, 6 Jan 2009 14:56:25 -0600
References: <1231275171-21388-1-git-send-email-galak@kernel.crashing.org>
Cc: netdev@vger.kernel.org, Leo Li <leo@rock.ap.freescale.net>,
	davem@davemloft.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 6, 2009, at 2:52 PM, Kumar Gala wrote:

> From: Leo Li <leo@rock.ap.freescale.net>
>
> When changing the link between 100Mbps and 1Gbps in SGMII mode it was
> found out that the link would stop working.  The issue is that  
> ECNTRL[R100]
> needs to be cleared when in 1Gbps mode.  Older reference manuals  
> didn't
> require the explicitly clearing but has since been found it that it is
> needed.
>
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Acked-by: Andy Fleming <afleming@freescale.com>
