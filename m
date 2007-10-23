Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B2094DDFEA
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 05:02:06 +1000 (EST)
Date: Tue, 23 Oct 2007 14:02:13 -0500
From: Scott Wood <scottwood@freescale.com>
To: Li Yang-r58472 <LeoLi@freescale.com>
Subject: Re: [PATCH v6 resend 9/9] add MPC837x MDS board default device tree
Message-ID: <20071023190213.GA4825@loki.buserror.net>
References: <1192720186-25228-1-git-send-email-leoli@freescale.com>
	<F1717431-3C1F-4528-9949-32C156F5DD4F@kernel.crashing.org>
	<989B956029373F45A0B8AF0297081890019B5BD6@zch01exm26.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <989B956029373F45A0B8AF0297081890019B5BD6@zch01exm26.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 18, 2007 at 11:10:43PM +0800, Li Yang-r58472 wrote:
> Do we still need address-cell and size-cell even when it has no child
> node?

Maybe not *need*, but we do want it...  it makes it less likely to be
screwed up if someone adds a child node in the future.

-Scott
