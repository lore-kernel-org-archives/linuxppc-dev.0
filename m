Return-Path: <B11780@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 516E8B713F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Jun 2011 21:42:03 +1000 (EST)
Subject: Re: [PATCH 4/7] powerpc: add Freescale hypervisor partition control
	functions
MIME-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1305813272-31826-5-git-send-email-timur@freescale.com>
Date: Wed, 22 Jun 2011 06:41:52 -0500
Message-ID: <CC6FDFDC-FB47-495E-B998-5D1CD115AA2D@freescale.com>
References: <1305813272-31826-1-git-send-email-timur@freescale.com>
	<1305813272-31826-5-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: linux-kernel@vger.kernel.org, akpm@kernel.org,
	linux-console@vger.kernel.org, greg@kroah.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 19, 2011, at 8:54 AM, Timur Tabi wrote:

> Add functions to restart and halt the current partition when running under
> the Freescale hypervisor.  These functions should be assigned to various
> function pointers of the ppc_md structure during the .probe() function for
> the board:
> 
> 	ppc_md.restart = fsl_hv_restart;
> 	ppc_md.power_off = fsl_hv_halt;
> 	ppc_md.halt = fsl_hv_halt;
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/sysdev/fsl_soc.c |   27 +++++++++++++++++++++++++++
> arch/powerpc/sysdev/fsl_soc.h |    3 +++
> 2 files changed, 30 insertions(+), 0 deletions(-)

applied to next

- k
