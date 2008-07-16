Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2B618DDF85
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 07:57:11 +1000 (EST)
Message-Id: <A25DDBB7-B107-4246-9A74-28CBF6EA2C56@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <1214346902-4363-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH v2] powerpc: fix ALSA options in Freescale 85xx and 86xx
	defconfigs
Date: Wed, 16 Jul 2008 16:57:03 -0500
References: <1214346902-4363-1-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 24, 2008, at 5:35 PM, Timur Tabi wrote:

> The defconfigs for Freescale 85xx and 86xx SOCs had bad choices for  
> some
> audio related options.  In particular, OSS emulation should be  
> enabled,
> and the old ALSA API should be disabled.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---

applied.

- k
