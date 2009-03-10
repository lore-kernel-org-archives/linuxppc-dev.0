Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C85BDDDF1F
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 05:57:13 +1100 (EST)
Message-Id: <0F2A6510-926C-4325-9C10-866E4159B24B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Liu Yu <Yu.Liu@freescale.com>
In-Reply-To: <1236654589-6624-1-git-send-email-yu.liu@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] efp: Fix efp dependence
Date: Tue, 10 Mar 2009 13:57:02 -0500
References: <1236654589-6624-1-git-send-email-yu.liu@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 9, 2009, at 10:09 PM, Liu Yu wrote:

> There is no dependece between efp and math-emu.
> But when disalbe math-emu, the efp code cannot be built.
> This patch fixes it.
>
> Signed-off-by: Liu Yu <yu.liu@freescale.com>
> ---
> It would be nice to see this patch go along with 2.6.29

not critical enough for .29.  applied to next for .30

(you can always ask for it get pulled in for .29.1)

- k
