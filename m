Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 69C3CDE01A
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Mar 2008 01:46:20 +1100 (EST)
Message-Id: <36E7CB5B-4C3B-4ED3-BC46-A87BA92BC150@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Vitaly Bordug <vitb@kernel.crashing.org>
In-Reply-To: <20080306135330.6d5462d2@vitb.ru.mvista.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [POWERPC] 8xx: fix swap
Date: Fri, 7 Mar 2008 08:46:14 -0600
References: <20080306135330.6d5462d2@vitb.ru.mvista.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 6, 2008, at 4:53 AM, Vitaly Bordug wrote:

> This makes swap routines operate correctly on the ppc_8xx based  
> machines.
> Code has been revalidated on mpc885ads (8M sdram) with recent  
> kernel. Based
> on patch from Yuri Tikhonov <yur@emcraft.com> to do the same on arch/ 
> ppc
> instance.
>
> Recent kernel's size makes swap feature very important on low-memory  
> platforms,
> those are actually non-operable without it.
>
> Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
> Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
> ---
>
> arch/powerpc/kernel/head_8xx.S      |   30 ++++++++++++++++++++++++++ 
> +++-
> include/asm-powerpc/pgtable-ppc32.h |    8 --------
> 2 files changed, 29 insertions(+), 9 deletions(-)

applied.

- k
