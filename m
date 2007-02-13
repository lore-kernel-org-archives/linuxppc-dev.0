Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6E528DDF5F
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 05:55:37 +1100 (EST)
Date: Tue, 13 Feb 2007 12:52:49 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] Updated mpc834x_itx_defconfig
In-Reply-To: <11710369101980-git-send-email-timur@freescale.com>
Message-ID: <Pine.LNX.4.64.0702131252330.24347@localhost.localdomain>
References: <11710369101980-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 9 Feb 2007, Timur Tabi wrote:

> This patch updates the defconfig for the MPC8349E-mITX.  In addition to picking
> up changes from recent kernels, it turns off math emulation, disables support
> for e100 (which doesn't ship with the system), turns off input devices,
> turns on some I2C support, turns off HW monitoring (HW not yet supported),
> turns off OHCI USB (not used), turns off USB gadget support (HW not yet
> supported), turns on DOS FS support, and turns off kernel debugging.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>

applied.

- k
