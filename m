Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2FC502C008D
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Mar 2013 20:05:51 +1100 (EST)
Subject: Re: [PATCH 2/2] powerpc/fsl-booke: Update DCSR EPU device tree entries
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1363633870-3894-2-git-send-email-galak@kernel.crashing.org>
Date: Thu, 21 Mar 2013 04:05:59 -0500
Message-Id: <E44BEAE2-E8F8-47CB-A405-E4811F36F32E@kernel.crashing.org>
References: <1363633870-3894-1-git-send-email-galak@kernel.crashing.org>
 <1363633870-3894-2-git-send-email-galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Cc: Stephen George <Stephen.George@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 18, 2013, at 2:11 PM, Kumar Gala wrote:

> From: Stephen George <Stephen.George@freescale.com>
> 
> Identifies the epu as compatible with Chassis v1 Debug IP.
> 
> Signed-off-by: Stephen George <Stephen.George@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/boot/dts/fsl/p2041si-post.dtsi |    2 +-
> arch/powerpc/boot/dts/fsl/p3041si-post.dtsi |    2 +-
> arch/powerpc/boot/dts/fsl/p4080si-post.dtsi |    2 +-
> arch/powerpc/boot/dts/fsl/p5020si-post.dtsi |    2 +-
> arch/powerpc/boot/dts/fsl/p5040si-post.dtsi |    2 +-
> 5 files changed, 5 insertions(+), 5 deletions(-)

applied to next

- k
