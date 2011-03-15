Return-Path: <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: sysdev: fix signedness bug
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1287327102-9068-1-git-send-email-segooon@gmail.com>
Date: Tue, 15 Mar 2011 14:19:23 -0500
Message-Id: <EA2A84CF-6A11-4CEC-B4FD-96F1262ED9AF@kernel.crashing.org>
References: <1287327102-9068-1-git-send-email-segooon@gmail.com>
To: Vasiliy Kulikov <segooon@gmail.com>
Cc: Harninder Rai <harninder.rai@freescale.com>,
	devicetree-discuss@lists.ozlabs.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
	Vivek Mahajan <vivek.mahajan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 17, 2010, at 9:51 AM, Vasiliy Kulikov wrote:

> sram_params.sram_size and sram_params.sram_offset were unsigned.
> If get_cache_sram_size() or get_cache_sram_offset() returns error code
> then it is not seen to the caller.  Made sram_size and sram_offset signed.
> 
> Signed-off-by: Vasiliy Kulikov <segooon@gmail.com>
> ---
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)

applied

- k
