Return-Path: <kumar.gala@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D9A3BB7145
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Nov 2010 23:20:12 +1100 (EST)
Subject: Re: [PATCH 1/4][v2] powerpc: add e500 HID1 bit definition
MIME-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1288776931-20689-1-git-send-email-b21989@freescale.com>
Date: Thu, 11 Nov 2010 06:20:00 -0600
Message-ID: <8215A0B4-135B-47B1-9D01-D0E5DD3243BD@freescale.com>
References: <1288776931-20689-1-git-send-email-b21989@freescale.com>
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


On Nov 3, 2010, at 4:35 AM, Shaohui Xie wrote:

> From: Li Yang <leoli@freescale.com>
> 
> Also make 74xx HID1 definition conditional.
> 
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Shaohui Xie <b21989@freescale.com>
> Cc: Li Yang <leoli@freescale.com>
> Cc: Kumar Gala <kumar.gala@freescale.com>
> Cc: Roy Zang <tie-fei.zang@freescale.com>
> Cc: Alexandre Bounine <alexandre.bounine@idt.com>
> ---
> These patches have been send for almost one week, and has no feedback.
> 
> arch/powerpc/include/asm/reg.h       |    2 ++
> arch/powerpc/include/asm/reg_booke.h |   14 ++++++++++++++
> 2 files changed, 16 insertions(+), 0 deletions(-)

applied to next

- k
