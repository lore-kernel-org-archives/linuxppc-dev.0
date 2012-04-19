Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 148B5B7083
 for <linuxppc-dev@ozlabs.org>; Fri, 20 Apr 2012 06:15:53 +1000 (EST)
Subject: Re: [PATCH 3/4] powerpc/mpic_msgr: fix offset error when setting mer
 register
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1334541908-19331-3-git-send-email-Mingkai.hu@freescale.com>
Date: Thu, 19 Apr 2012 15:15:45 -0500
Message-Id: <212FFF6C-1704-422C-93CC-200D00DA53E3@kernel.crashing.org>
References: <1334541908-19331-1-git-send-email-Mingkai.hu@freescale.com>
 <1334541908-19331-2-git-send-email-Mingkai.hu@freescale.com>
 <1334541908-19331-3-git-send-email-Mingkai.hu@freescale.com>
To: Mingkai Hu <Mingkai.hu@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 15, 2012, at 9:05 PM, Mingkai Hu wrote:

> Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
> ---
> arch/powerpc/sysdev/mpic_msgr.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

applied to merge

- k
