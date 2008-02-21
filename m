Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2A32EDDED3
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2008 06:54:41 +1100 (EST)
Message-ID: <47BDD717.2040601@freescale.com>
Date: Thu, 21 Feb 2008 13:55:03 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] [USB POWERPC] ehci-fsl: add PPC_MPC837x to default y
References: <20080221195021.GC12896@localhost.localdomain>
In-Reply-To: <20080221195021.GC12896@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> Without this patch it's impossible to select ehci-fsl on PPC_MPC837x.
> Another option would be to convert USB_EHCI_FSL to verbose bool,
> but I presume EHCI_FSL is purposely made silent.

I think making it verbose bool would be better.

-Scott
