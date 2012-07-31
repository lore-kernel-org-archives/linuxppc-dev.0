Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 37F062C009E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2012 00:25:08 +1000 (EST)
Subject: Re: [PATCH v8 1/7] powerpc/smp: use a struct epapr_spin_table to
 replace macros
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1342788159-27529-2-git-send-email-chenhui.zhao@freescale.com>
Date: Tue, 31 Jul 2012 09:24:16 -0500
Message-Id: <4C0232AB-6B1D-4D35-9400-941F3BE9AFC2@kernel.crashing.org>
References: <1342788159-27529-1-git-send-email-chenhui.zhao@freescale.com>
 <1342788159-27529-2-git-send-email-chenhui.zhao@freescale.com>
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 20, 2012, at 7:42 AM, Zhao Chenhui wrote:

> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> ---
> arch/powerpc/platforms/85xx/smp.c |   46 =
++++++++++++++++++------------------
> 1 files changed, 23 insertions(+), 23 deletions(-)

applied to next

- k=
