Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 85964DDF92
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 21:50:22 +1000 (EST)
Message-Id: <81C5EBA4-87B0-4132-B527-3CC35962B668@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Haiying Wang <Haiying.Wang@freescale.com>
In-Reply-To: <12410288792524-git-send-email-Haiying.Wang@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 2/6] powerpc/qe: update risc allocation for QE
Date: Thu, 30 Apr 2009 06:48:11 -0500
References: <1241028878175-git-send-email-Haiying.Wang@freescale.com>
	<12410288792524-git-send-email-Haiying.Wang@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 29, 2009, at 1:14 PM, Haiying Wang wrote:

> Change the RISC allocation to macros instead of enum, add function  
> to read the
> number of risc engines from the new property "num-riscs" under qe  
> node in dts.
> Add new property "num-riscs" description in qe.txt
>
> Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
> ---
> .../powerpc/dts-bindings/fsl/cpm_qe/qe.txt         |    1 +
> arch/powerpc/include/asm/qe.h                      |   18 ++++++++----
> arch/powerpc/sysdev/qe_lib/qe.c                    |   28 +++++++++++ 
> +++++++++
> 3 files changed, 41 insertions(+), 6 deletions(-)

I'm wondering if these should be fsl,num-riscs or fsl,qe-num-riscs  
since its a new property.  Ditto for num-snums.

Also, shouldn't both of these be in the Required section of the binding.

- k
