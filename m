Return-Path: <B11780@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 56FF9B6F97
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Jun 2011 21:41:39 +1000 (EST)
Subject: Re: [PATCH 1/7] powerpc: make irq_choose_cpu() available to all PIC
	drivers
MIME-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1305813272-31826-2-git-send-email-timur@freescale.com>
Date: Wed, 22 Jun 2011 06:41:26 -0500
Message-ID: <9215F3F9-AA0A-4C76-B2F0-DF18A9FAAB35@freescale.com>
References: <1305813272-31826-1-git-send-email-timur@freescale.com>
	<1305813272-31826-2-git-send-email-timur@freescale.com>
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

> From: Stuart Yoder <stuart.yoder@freescale.com>
> 
> Move irq_choose_cpu() into arch/powerpc/kernel/irq.c so that it can be used
> by other PIC drivers.  The function is not MPIC-specific.
> 
> Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/include/asm/irq.h |    2 ++
> arch/powerpc/kernel/irq.c      |   35 +++++++++++++++++++++++++++++++++++
> arch/powerpc/sysdev/mpic.c     |   36 ------------------------------------
> 3 files changed, 37 insertions(+), 36 deletions(-)

applied to next

- k
