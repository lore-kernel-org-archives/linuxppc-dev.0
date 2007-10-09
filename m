Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0C564DE00F
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 01:56:39 +1000 (EST)
In-Reply-To: <1191945199488-git-send-email-timur@freescale.com>
References: <1191945199488-git-send-email-timur@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B8D11E08-7AC5-4B21-9C40-1068B29B058B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] qe: add function qe_clock_source
Date: Tue, 9 Oct 2007 10:56:53 -0500
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


On Oct 9, 2007, at 10:53 AM, Timur Tabi wrote:

> Add function qe_clock_source() which takes a string containing the  
> name of a
> QE clock source (as is typically found in device trees) and returns  
> the
> matching enum qe_clock value.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> This patch applies to Kumar's for-2.6.24 branch.
>
>  arch/powerpc/sysdev/qe_lib/qe.c |   65 ++++++++++++++++++++++++++++ 
> +++++++++++
>  include/asm-powerpc/qe.h        |    3 ++
>  2 files changed, 68 insertions(+), 0 deletions(-)

I'm sure its asking to much of the QE HW for BRGs or CLKs to be  
sequential.

- k
