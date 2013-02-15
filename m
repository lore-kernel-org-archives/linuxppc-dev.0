Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4BEDE2C0298
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Feb 2013 07:14:50 +1100 (EST)
Subject: Re: [PATCH 2/2] powerpc/e500/qemu-e500: enable coreint
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1358819804-28665-3-git-send-email-scottwood@freescale.com>
Date: Fri, 15 Feb 2013 14:14:52 -0600
Message-Id: <B0993756-4977-4DA3-AAAC-49292762C8A5@kernel.crashing.org>
References: <1358819804-28665-1-git-send-email-scottwood@freescale.com>
 <1358819804-28665-3-git-send-email-scottwood@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 21, 2013, at 7:56 PM, Scott Wood wrote:

> The MPIC code will disable coreint if it detects an insufficient
> MPIC version.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> arch/powerpc/platforms/85xx/qemu_e500.c |    7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)

applied to next

- k
