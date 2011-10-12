Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7C3F1B6F7F
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Oct 2011 15:21:49 +1100 (EST)
Subject: Re: [PATCH 1/4] powerpc/85xx: Rename PowerPC core nodes to match
 other e500mc based .dts
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1314905175-4371-1-git-send-email-galak@kernel.crashing.org>
Date: Tue, 11 Oct 2011 23:21:44 -0500
Message-Id: <13CDA4CE-F65E-4853-90C7-DFDC684084C7@kernel.crashing.org>
References: <1314905175-4371-1-git-send-email-galak@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 1, 2011, at 2:26 PM, Kumar Gala wrote:

> The P4080 silicon device tree was using PowerPC,4080 while the other
> e500mc based SoCs used PowerPC,e500mc.  Use the core name to be
> consistent going forward.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/boot/dts/p4080si.dtsi |   16 ++++++++--------
> 1 files changed, 8 insertions(+), 8 deletions(-)

applied

- k
