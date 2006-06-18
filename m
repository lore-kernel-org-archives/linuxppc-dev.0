Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 132F267B31
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jun 2006 00:22:29 +1000 (EST)
In-Reply-To: <E1Frjec-0004Oc-Ou@jdl.com>
References: <E1Frjec-0004Oc-Ou@jdl.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5FB36A37-1230-4D17-8B23-F558F109444A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 0/9 v3] Introduce the MPC8641 HPCN platform
Date: Sun, 18 Jun 2006 09:23:15 -0500
To: Jon Loeliger <jdl@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 17, 2006, at 5:52 PM, Jon Loeliger wrote:

>
> This is the third posting of a series of patches
> that introduces the MPC8641 HPCN platform.  This
> version corrects all of the suggestions from Kumar,
> and shows an ACK from Jeff Garzik for the netdev
> related parts.  It also addresses all of the problems
> that Ben brought up related to multi-platform issues.
> It does not use IRQ settings from the device tree yet;
> that will come as a follow on patch when Ben's IRQ
> rewrite is more solid.
>
> Please consider this for addition into the 2.6.18 queue.

General question, have you run these patches through sparse?

>
> Collectively:
>
> Signed-off-by: Jon Loeliger <jdl@freescale.com>
> Signed-off-by: Xianghua Xiao <x.xiao@freescale.com>
> Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
> Signed-off-by: Wei Zhang <Wei.Zhang@freescale.com>
> Signed-off-by: Jeff Brown <Jeff.Brown@freescale.com>
> Signed-off-by: Kriston Carson <KristonCarson@freescale.com>
> Acked-by: Jeff Garzik <jeff@garzik.org>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
