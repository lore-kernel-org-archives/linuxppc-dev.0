Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 807F167CDF
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Oct 2006 14:26:58 +1000 (EST)
In-Reply-To: <20061003231751.00484d8a.kim.phillips@freescale.com>
References: <20061003231751.00484d8a.kim.phillips@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CEA95FBE-ED7E-4512-A6C5-6362DAE69744@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 4/7] Add MPC8360EMDS board support (try 2)
Date: Tue, 3 Oct 2006 23:27:42 -0500
To: Kim Phillips <kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 3, 2006, at 11:17 PM, Kim Phillips wrote:

> From: Li Yang <leoli@freescale.com>
>
> The patch adds MPC8360EMDS board support (get_bcsr removed).
>
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Yin Olivia <hong-hua.yin@freescale.com>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
>  arch/powerpc/configs/mpc8360emds_defconfig | 1018 +++++++++++++++++ 
> +++++++++++
>  arch/powerpc/platforms/83xx/mpc8360e_pb.c  |  220 ++++++
>  arch/powerpc/platforms/83xx/mpc8360e_pb.h  |   23 +
>  3 files changed, 1261 insertions(+), 0 deletions(-)

What's the point of the mpc8360e_pb.h if there's nothing in it?

Also, any reason the files are _pb and config is emds?

- k
