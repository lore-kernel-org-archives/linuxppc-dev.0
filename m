Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AFFC3DDEF0
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 08:05:56 +1000 (EST)
Message-Id: <9C2A5F5C-422E-48E4-BA0C-173FA9683542@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Haiying Wang <Haiying.Wang@freescale.com>
In-Reply-To: <1241206851-27749-2-git-send-email-Haiying.Wang@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 4/6 v2] powerpc/qe: update QE Serial Number
Date: Fri, 1 May 2009 17:03:49 -0500
References: <1241206851-27749-1-git-send-email-Haiying.Wang@freescale.com>
	<1241206851-27749-2-git-send-email-Haiying.Wang@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 1, 2009, at 2:40 PM, Haiying Wang wrote:

> The latest QE chip may have more Serial Number(SNUM)s of thread to  
> use. We will
> get the number of SNUMs from device tree by reading the new property
> "fsl,qe-num-snums", and set 28 as the default number of SNUMs so  
> that it is
> compatible with the old QE chips' device trees which don't have this  
> new
> property. The macro QE_NUM_OF_SNUM is defined as the maximum number  
> in QE snum
> table which is 256.
> Also we update the snum_init[] array with 18 more new SNUMs which are
> confirmed to be useful on new chip.
>
> Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
> ---
> v2 change: rename the new property as "fsl,qe-num-snums" and move it  
> to Required
> section in qe.txt
> .../powerpc/dts-bindings/fsl/cpm_qe/qe.txt         |    2 +
> arch/powerpc/include/asm/qe.h                      |    3 +-
> arch/powerpc/sysdev/qe_lib/qe.c                    |   47 +++++++++++ 
> +++++++--
> 3 files changed, 47 insertions(+), 5 deletions(-)

applied

- k
