Return-Path: <kumar.gala@freescale.com>
Received: from VA3EHSOBE004.bigfish.com (va3ehsobe004.messaging.microsoft.com
	[216.32.180.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B9425B714F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Nov 2010 23:35:26 +1100 (EST)
Subject: Re: [PATCH 2/4][v2] fsl_rio: fix non-standard HID1 register access
MIME-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1288776997-23562-1-git-send-email-b21989@freescale.com>
Date: Thu, 11 Nov 2010 06:20:02 -0600
Message-ID: <BD0B9175-F78C-49FB-8938-697ECA659B82@freescale.com>
References: <1288776997-23562-1-git-send-email-b21989@freescale.com>
To: Shaohui Xie <b21989@freescale.com>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>, akpm@linux-foundation.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 3, 2010, at 4:36 AM, Shaohui Xie wrote:

> Signed-off-by: Shaohui Xie <b21989@freescale.com>
> Cc: Li Yang <leoli@freescale.com>
> Cc: Kumar Gala <kumar.gala@freescale.com>
> Cc: Roy Zang <tie-fei.zang@freescale.com>
> Cc: Alexandre Bounine <alexandre.bounine@idt.com>
> ---
> arch/powerpc/kernel/cpu_setup_fsl_booke.S |    6 ++++++
> arch/powerpc/sysdev/fsl_rio.c             |    2 --
> 2 files changed, 6 insertions(+), 2 deletions(-)

applied to next

- k
