Return-Path: <B11780@freescale.com>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BB2B2B735A
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 23:55:08 +1000 (EST)
Subject: Re: [PATCH 1/2][v4] fsl_rio: move machine_check handler into
	machine_check_e500 & machine_check_e500mc
MIME-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1290063452-20873-1-git-send-email-b21989@freescale.com>
Date: Fri, 20 May 2011 08:53:10 -0500
Message-ID: <CA2A9156-D912-4633-8F50-5B4CE1B1F495@freescale.com>
References: <1290063452-20873-1-git-send-email-b21989@freescale.com>
To: Shaohui Xie <b21989@freescale.com>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>, akpm@linux-foundation.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 18, 2010, at 12:57 AM, Shaohui Xie wrote:

> Signed-off-by: Shaohui Xie <b21989@freescale.com>
> Cc: Li Yang <leoli@freescale.com>
> Cc: Kumar Gala <kumar.gala@freescale.com>
> Cc: Roy Zang <tie-fei.zang@freescale.com>
> Cc: Alexandre Bounine <alexandre.bounine@idt.com>
> ---
> arch/powerpc/include/asm/rio.h |    5 +++++
> arch/powerpc/kernel/traps.c    |   13 +++++++++++++
> arch/powerpc/sysdev/fsl_rio.c  |   15 +++------------
> 3 files changed, 21 insertions(+), 12 deletions(-)

applied to merge

- k
