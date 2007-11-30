Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2C26FDDDEB
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 11:35:43 +1100 (EST)
Message-Id: <0BCAE755-0506-405D-BFCA-94C2261CBE30@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Li Yang <leoli@freescale.com>
In-Reply-To: <1192793930-26039-8-git-send-email-leoli@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH v7 7/9] ipic: clean up unsupported ack operations
Date: Thu, 29 Nov 2007 18:35:35 -0600
References: <1192793930-26039-1-git-send-email-leoli@freescale.com>
	<1192793930-26039-2-git-send-email-leoli@freescale.com>
	<1192793930-26039-3-git-send-email-leoli@freescale.com>
	<1192793930-26039-4-git-send-email-leoli@freescale.com>
	<1192793930-26039-5-git-send-email-leoli@freescale.com>
	<1192793930-26039-6-git-send-email-leoli@freescale.com>
	<1192793930-26039-7-git-send-email-leoli@freescale.com>
	<1192793930-26039-8-git-send-email-leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 19, 2007, at 6:38 AM, Li Yang wrote:

> IPIC controller doesn't support ack operations.  The pending registers
> are read-only.  The patch removes ack operations which are not needed.
>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/sysdev/ipic.c |   40 + 
> +--------------------------------------
> 1 files changed, 2 insertions(+), 38 deletions(-)

applied.

- 
