Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 887D0DDEBE
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 17:38:28 +1100 (EST)
Message-Id: <F1F72DC6-5A19-4730-909B-02F7A6EB8E76@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Li Yang <leoli@freescale.com>
In-Reply-To: <1199776726-22963-2-git-send-email-leoli@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 3/3 v2] USB device tree cleanups
Date: Fri, 18 Jan 2008 00:38:14 -0600
References: <1199776726-22963-1-git-send-email-leoli@freescale.com>
	<1199776726-22963-2-git-send-email-leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 8, 2008, at 1:18 AM, Li Yang wrote:

> Remove device_type = "usb"
>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> Documentation/powerpc/booting-without-of.txt |    4 ----
> arch/powerpc/boot/dts/mpc8313erdb.dts        |    1 -
> arch/powerpc/boot/dts/mpc832x_mds.dts        |    1 -
> arch/powerpc/boot/dts/mpc8349emitx.dts       |    2 --
> arch/powerpc/boot/dts/mpc8349emitxgp.dts     |    1 -
> arch/powerpc/boot/dts/mpc834x_mds.dts        |    2 --
> arch/powerpc/boot/dts/mpc836x_mds.dts        |    1 -
> arch/powerpc/platforms/83xx/usb.c            |    8 ++++----
> arch/powerpc/sysdev/fsl_soc.c                |   12 +++++-------
> 9 files changed, 9 insertions(+), 23 deletions(-)

applied.

- k
