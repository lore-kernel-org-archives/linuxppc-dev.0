Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3FBA72C037F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2012 02:07:24 +1000 (EST)
Subject: Re: [PATCH] powerpc: add adt7461 thermal monitor support to
 applicable boards
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1346119255-19031-1-git-send-email-B38951@freescale.com>
Date: Thu, 30 Aug 2012 11:07:17 -0500
Message-Id: <A06AD81D-C153-4DA6-8DBB-E1C5066C3529@kernel.crashing.org>
References: <1346119255-19031-1-git-send-email-B38951@freescale.com>
To: Jia Hongtao <B38951@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 27, 2012, at 9:00 PM, Jia Hongtao wrote:

> Add thermal monitor support to following boards:
> P1022DS, MPC8536DS, P2041RDB, P3041DS, P4080DS, P5020DS, P5040DS
> 
> Signed-off-by: Jia Hongtao <B38951@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/boot/dts/mpc8536ds.dtsi |    4 ++++
> arch/powerpc/boot/dts/p1022ds.dtsi   |    4 ++++
> arch/powerpc/boot/dts/p2041rdb.dts   |    4 ++++
> arch/powerpc/boot/dts/p3041ds.dts    |    4 ++++
> arch/powerpc/boot/dts/p4080ds.dts    |    4 ++++
> arch/powerpc/boot/dts/p5020ds.dts    |    4 ++++
> arch/powerpc/boot/dts/p5040ds.dts    |    4 ++++
> 7 files changed, 28 insertions(+), 0 deletions(-)

applied to next

- k
