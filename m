Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8BA46B7853
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Nov 2011 05:01:36 +1100 (EST)
Subject: Re: [PATCH] powerpc/cpm: Clear muram before it is in use.
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1319008732-8057-1-git-send-email-galak@kernel.crashing.org>
Date: Thu, 3 Nov 2011 13:01:18 -0500
Message-Id: <CAA93274-85A1-4208-858C-3BB2F319D585@kernel.crashing.org>
References: <1319008732-8057-1-git-send-email-galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Cc: Hongjun Chen <Hong-jun.Chen@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 19, 2011, at 2:18 AM, Kumar Gala wrote:

> From: Hongjun Chen <Hong-jun.Chen@freescale.com>
> 
> We need to ensure that MURAM is in a known and cleared out state before
> using it as the bootloader could have utilized it from its own purposes
> and left it in an unknown state.
> 
> If we don't clear it out we've seen issues with UCC ethernet:
> * Multi ethernet interfaces can't work simultanously.
> * Multi up/down Ethernet interfaces will halt these ports.
> * UCC1 RGMII can't work when kernel boots from some hosts.
> 
> Signed-off-by: Kai.Jiang <Kai.Jiang@freescale.com>
> Signed-off-by: Hongjun Chen <Hong-jun.Chen@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/sysdev/cpm_common.c |    3 ++-
> 1 files changed, 2 insertions(+), 1 deletions(-)

applied

- k
