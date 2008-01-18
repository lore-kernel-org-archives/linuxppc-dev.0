Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 60017DDF97
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 03:48:32 +1100 (EST)
Date: Fri, 18 Jan 2008 10:45:17 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v4] [POWERPC] Update MPC8610 HPCD to support audio drivers
In-Reply-To: <12006698934064-git-send-email-timur@freescale.com>
Message-ID: <Pine.LNX.4.64.0801181042290.31902@blarg.am.freescale.net>
References: <12006698934064-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 18 Jan 2008, Timur Tabi wrote:

> Update the MPC8610 HPCD files to support the audio driver.  Update
> booting-without-of.txt with information on the SSI device.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> Rebased for Kumar's repo.
>
>  Documentation/powerpc/booting-without-of.txt |   41 ++++++
>  arch/powerpc/boot/dts/mpc8610_hpcd.dts       |  113 +++++++++++++++++-
>  arch/powerpc/configs/mpc8610_hpcd_defconfig  |  171 +++++++++++++++++++++++++-
>  arch/powerpc/platforms/86xx/mpc8610_hpcd.c   |   15 +++
>  4 files changed, 336 insertions(+), 4 deletions(-)

applied.

- k
