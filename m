Return-Path: <galak@kernel.crashing.org>
Message-Id: <B07CD9F9-150F-4F32-9AE0-7C184B3EA970@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
In-Reply-To: <2d219a4998d568c5925727ce61ca440dfb25f5e7.1250266325.git.paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH 1/2] powerpc: issue fsl_soc reboot warning only when
	applicable
Date: Fri, 14 Aug 2009 15:21:03 -0500
References: <2d219a4998d568c5925727ce61ca440dfb25f5e7.1250266325.git.paul.gortmaker@windriver.com>
Cc: Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 14, 2009, at 11:13 AM, Paul Gortmaker wrote:

> Some CPU, like the MPC8560 don't have a RSTCR in the Global
> Utilities Block.  These boards will implement their own reboot
> call, and not use this code, so we should only warn about the
> absence of the GUTS RSTCR when the default reboot code is used.
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
> arch/powerpc/sysdev/fsl_soc.c |    6 ++++--
> 1 files changed, 4 insertions(+), 2 deletions(-)


applied to next

- k
