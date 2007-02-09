Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4627FDDE49
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 07:05:37 +1100 (EST)
In-Reply-To: <11710512363897-git-send-email-timur@freescale.com>
References: <11710512363897-git-send-email-timur@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <317DF39B-8D20-431A-80D1-74CAE643B241@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add support for MPC8349E-mITX-GP
Date: Fri, 9 Feb 2007 14:04:41 -0600
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 9, 2007, at 2:00 PM, Timur Tabi wrote:

> This patch adds a defconfig and a DTS for the MPC8349E-mITX-GP, a  
> variant of
> the MPC8349E-mITX.
>
> USB is disabled because the only active USB port currently is not  
> supported
> in the kernel.

What is not supported?  We support both MPH and DR on 834x?

- k
