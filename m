Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A2077100A6D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 17:41:09 +1100 (EST)
Subject: Re: [PATCH 1/4] powerpc/83xx: consolidate of_platform_bus_probe calls
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1321541330-2330-1-git-send-email-dbaryshkov@gmail.com>
Date: Thu, 24 Nov 2011 00:40:38 -0600
Message-Id: <E1D730EB-F44D-49D4-B8CB-BF593C348C2E@kernel.crashing.org>
References: <1321541330-2330-1-git-send-email-dbaryshkov@gmail.com>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 17, 2011, at 8:48 AM, Dmitry Eremin-Solenikov wrote:

> 83xx board files have a lot of duplication in
> *_declare_of_platform_devices() functions. Merge that into a single
> function common to most of the boards.
> 
> The only leftover is mpc834x_itx.c board file which explicitly asks for
> fsl,pq2pro-localbus, as corresponding bindings don't provide
> "simple-bus" compatibility in localbus node.
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
> arch/powerpc/platforms/83xx/asp834x.c     |   15 +--------------
> arch/powerpc/platforms/83xx/km83xx.c      |   18 +-----------------
> arch/powerpc/platforms/83xx/misc.c        |   17 +++++++++++++++++
> arch/powerpc/platforms/83xx/mpc830x_rdb.c |   13 +------------
> arch/powerpc/platforms/83xx/mpc831x_rdb.c |   14 +-------------
> arch/powerpc/platforms/83xx/mpc832x_mds.c |   18 +-----------------
> arch/powerpc/platforms/83xx/mpc832x_rdb.c |   18 +-----------------
> arch/powerpc/platforms/83xx/mpc834x_itx.c |    3 +--
> arch/powerpc/platforms/83xx/mpc834x_mds.c |   15 +--------------
> arch/powerpc/platforms/83xx/mpc836x_mds.c |   18 +-----------------
> arch/powerpc/platforms/83xx/mpc836x_rdk.c |   11 +----------
> arch/powerpc/platforms/83xx/mpc837x_mds.c |   17 +----------------
> arch/powerpc/platforms/83xx/mpc837x_rdb.c |   18 +-----------------
> arch/powerpc/platforms/83xx/mpc83xx.h     |    1 +
> arch/powerpc/platforms/83xx/sbc834x.c     |   15 +--------------
> 15 files changed, 31 insertions(+), 180 deletions(-)

applied to next

- k
