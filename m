Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E48FEDDFC8
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 17:47:28 +1100 (EST)
In-Reply-To: <45C96864.3040009@freescale.com>
References: <45C96864.3040009@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <88E8218F-FB12-4E03-AD5B-8EBB926D4923@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/3] add platform_device for USB DR pheripheral driver
Date: Thu, 8 Feb 2007 00:47:02 -0600
To: Li Yang <leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 6, 2007, at 11:49 PM, Li Yang wrote:

> Add platform_device setup code for OTG/peripheral mode of
> 834x DR module.  It is needed for USB client driver to work.
>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/sysdev/fsl_soc.c |   76 ++++++++++++++++++++++++++++++ 
> +----------
> 1 files changed, 58 insertions(+), 18 deletions(-)

applied.

- k
