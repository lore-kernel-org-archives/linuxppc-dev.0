Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7C4A0B6F7C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2011 15:24:49 +1100 (EST)
Subject: Re: [PATCH] powerpc: e500mc: Fix: use CONFIG_PPC_E500MC in idle_e500.S
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1318312568-23181-1-git-send-email-bharat.bhushan@freescale.com>
Date: Tue, 11 Oct 2011 23:24:42 -0500
Message-Id: <CD96DECB-417E-4AF0-95F8-CFCE267C32D8@kernel.crashing.org>
References: <1318312568-23181-1-git-send-email-bharat.bhushan@freescale.com>
To: Bharat Bhushan <r65777@freescale.com>
Cc: Bharat Bhushan <bharat.bhushan@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, bharatb.yadav@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 11, 2011, at 12:56 AM, Bharat Bhushan wrote:

> It is wrongly using undefined CONFIG_E500MC.
> 
> Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
> ---
> arch/powerpc/kernel/idle_e500.S |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

applied, can you send this linux-stable for v3.0.x inclusion

- k
