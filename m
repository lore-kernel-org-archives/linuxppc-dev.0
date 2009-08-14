Return-Path: <galak@kernel.crashing.org>
Message-Id: <E41164E1-E821-4633-A785-A8945E2AC005@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
In-Reply-To: <4935eb5c085f994943e2f989a74c1333c60aebf1.1250266325.git.paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH 2/2] sbc8560: remove "has-rstcr" from global utilities
	block
Date: Fri, 14 Aug 2009 15:21:12 -0500
References: <2d219a4998d568c5925727ce61ca440dfb25f5e7.1250266325.git.paul.gortmaker@windriver.com>
	<4935eb5c085f994943e2f989a74c1333c60aebf1.1250266325.git.paul.gortmaker@windriver.com>
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

> The earlier mpc8560 CPUs don't have the RSTCR at 0xe00b0
> in the GUTS.  The generic reboot code uses this tag to
> determine if it should be using the RSTCR for reboot, so
> remove it from the board definition.
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
> arch/powerpc/boot/dts/sbc8560.dts |    1 -
> 1 files changed, 0 insertions(+), 1 deletions(-)


applied to next

- k
