Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4C3B4DDF5C
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 04:02:47 +1000 (EST)
Date: Thu, 12 Apr 2007 12:58:50 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: [PATCH 1/3] [PPC32] MPC8272ads build fixed, defconfig refreshed.
In-Reply-To: <20070410175153.8806.90306.stgit@vitb.ru.mvista.com>
Message-ID: <Pine.LNX.4.64.0704121258330.11305@localhost.localdomain>
References: <20070410175153.8806.90306.stgit@vitb.ru.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>
> Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
> ---
>
>  arch/ppc/configs/ads8272_defconfig    |  592 ++++++++++++++++++++++++++-------
>  arch/ppc/platforms/mpc8272ads_setup.c |   17 +
>  2 files changed, 479 insertions(+), 130 deletions(-)
>

applied.

- k
