Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 68A3ADDE08
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 15:33:12 +1000 (EST)
In-Reply-To: <20070828201618.GA24210@ld0162-tx32.am.freescale.net>
References: <20070828201618.GA24210@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1E0D95DC-03E8-4BF0-9E22-69AECFA73FCF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/3] fsl_soc.c cleanup
Date: Tue, 11 Sep 2007 00:35:56 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 28, 2007, at 3:16 PM, Scott Wood wrote:

> 1. Fix get_immrbase() to use ranges, rather than reg.
>
> It is not always the case that the SoC's first reg property points
> to the beginning of the entire SoC block.

when is this true?

Upon further testing this breaks some platforms.  I don't think  
assuming the first range entry is mapping to the SOC register space  
is a good idea.

I've dropped this portion of the patch from my tree for the time being.

- k
