Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D5D12DDE28
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 14:37:54 +1000 (EST)
Message-Id: <E3621358-6929-4746-88AC-F6CE7B79DF58@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Haiying Wang <Haiying.Wang@freescale.com>
In-Reply-To: <1241028883630-git-send-email-Haiying.Wang@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 4/6] powerpc/qe: update QE Serial Number
Date: Wed, 29 Apr 2009 23:35:43 -0500
References: <1241028878175-git-send-email-Haiying.Wang@freescale.com>
	<12410288792524-git-send-email-Haiying.Wang@freescale.com>
	<12410288811793-git-send-email-Haiying.Wang@freescale.com>
	<1241028883630-git-send-email-Haiying.Wang@freescale.com>
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

> The latest QE chip may have more Serial Number(SNUM)s of thread to  
> use. We will
> get the number of SNUMs from device tree by reading the new property  
> "num-snums"
> , and set 28 as the default number of SNUMs so that it is compatible  
> with the
> old QE chips' device trees  which don't have this new property.
> The macro QE_NUM_OF_SNUM is defined as the maximum number in QE snum  
> table which
> is 256.
> Also we update the snum_init[] array with 18 more new SNUMs which are
> confirmed to be useful on new chip.
>
> Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
> ---
> .../powerpc/dts-bindings/fsl/cpm_qe/qe.txt         |    1 +
> arch/powerpc/include/asm/qe.h                      |    3 +-
> arch/powerpc/sysdev/qe_lib/qe.c                    |   47 +++++++++++ 
> +++++++--
> 3 files changed, 46 insertions(+), 5 deletions(-)

how about updating the existing .dts for this as well.  (One patch w/ 
this and # riscs is fine).

- k
