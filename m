Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C94412C01FB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Apr 2013 05:51:16 +1000 (EST)
Subject: Re: [PATCH v2] powerpc/dts: Fix the dts for p1025rdb 36bit
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1364174586-26158-1-git-send-email-B32736@freescale.com>
Date: Mon, 29 Apr 2013 14:51:05 -0500
Message-Id: <D9496F15-CC30-4EA4-AC9B-BB359E6D0838@kernel.crashing.org>
References: <1364174586-26158-1-git-send-email-B32736@freescale.com>
To: Zhicheng Fan <B32736@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 24, 2013, at 8:23 PM, Zhicheng Fan wrote:

> fix the following errors:
> 	Error: arch/powerpc/boot/dts/p1025rdb.dtsi:326.2-3 label or =
path, 'qe', not found
> 	Error: arch/powerpc/boot/dts/fsl/p1021si-post.dtsi:242.2-3 label =
or path, 'qe', not found
> 	FATAL ERROR: Syntax error parsing input tree
>=20
> Signed-off-by: Zhicheng Fan <B32736@freescale.com>
> ---
> arch/powerpc/boot/dts/p1025rdb_36b.dts |    5 +++++
> 1 files changed, 5 insertions(+), 0 deletions(-)

applied to next

- k=
