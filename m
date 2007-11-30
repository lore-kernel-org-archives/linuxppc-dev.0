Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 02EE7DDF46
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 11:37:52 +1100 (EST)
Message-Id: <0ADE6A43-33D8-4C01-8067-1F124050701D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <11963787903105-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH v2] qe: change qe_setbrg() to take an enum qe_clock
	instead of an integer
Date: Thu, 29 Nov 2007 18:37:44 -0600
References: <11963787903105-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 29, 2007, at 5:26 PM, Timur Tabi wrote:

> qe_setbrg() currently takes an integer to indicate the BRG number.   
> Change that
> to take an enum qe_clock instead, since this enum is intended to  
> represent
> clock sources.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> This patch applies to Kumar's for-2.6.25 branch.  You might need to  
> apply my
> other patch, "qe: fix device tree lookup code in qe_muram_init()",  
> first.
>
> It's safe to change the parameters to qe_setbrg() because no one is  
> using that
> function yet.
>
> arch/powerpc/sysdev/qe_lib/qe.c |   14 ++++--
> include/asm-powerpc/qe.h        |   94 ++++++++++++++++++ 
> +-------------------
> 2 files changed, 56 insertions(+), 52 deletions(-)

applied.

- k
