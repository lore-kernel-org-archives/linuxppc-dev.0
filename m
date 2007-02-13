Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 572DCDDEE5
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 04:17:37 +1100 (EST)
In-Reply-To: <11713852392294-git-send-email-timur@freescale.com>
References: <11713852392294-git-send-email-timur@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1712A11E-2F9F-441E-97E2-6FE82ED5A539@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: delete boot-cpu and chosen nodes from all DTS
	files
Date: Tue, 13 Feb 2007 11:16:55 -0600
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 13, 2007, at 10:47 AM, Timur Tabi wrote:

> The 'linux,boot-cpu' property and the 'chosen' node do not belong  
> in the
> DTS file, because U-Boot creates these entries in the device tree when
> it boots linux.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---

Is there some harm is having them set in the .dts?

I can see 'linux,boot-cpu' may vary on a SMP, but the majority  
of .dts's are for uniproc's

- k
