Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BA23167CD5
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 09:32:51 +1100 (EST)
In-Reply-To: <11631085643554-git-send-email-timur@freescale.com>
References: <11631085643554-git-send-email-timur@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <872BB6C6-FF0A-45BB-A403-FA945DC30210@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Optimize qe_brg struct to use an array
Date: Thu, 9 Nov 2006 16:32:49 -0600
To: timur@freescale.com
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 9, 2006, at 3:42 PM, timur@freescale.com wrote:

> From: Timur Tabi <timur@freescale.com>
>
> The qe_brg structure manually defined each of the 16 BRG registers,  
> which
> made any code that used them cumbersome.  This patch replaces the  
> fields
> with a single 16-element array.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
