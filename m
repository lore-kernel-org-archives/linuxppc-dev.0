Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5A557100863
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 17:41:22 +1100 (EST)
Subject: Re: [PATCH 2/4] powerpc/83xx: merge PCI bridge additions
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1321541330-2330-2-git-send-email-dbaryshkov@gmail.com>
Date: Thu, 24 Nov 2011 00:40:50 -0600
Message-Id: <BAE1870F-14EA-495E-B29F-CCBE0FC86243@kernel.crashing.org>
References: <1321541330-2330-1-git-send-email-dbaryshkov@gmail.com>
 <1321541330-2330-2-git-send-email-dbaryshkov@gmail.com>
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

> Nearly all mpc83xx-based boards have a common piece of code - one that
> loops over all pci/pcie bridges and registers them. Merge that code into
> a special function common to all boards.
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
> arch/powerpc/platforms/83xx/km83xx.c      |    7 +++----
> arch/powerpc/platforms/83xx/misc.c        |   14 ++++++++++++++
> arch/powerpc/platforms/83xx/mpc831x_rdb.c |   11 +----------
> arch/powerpc/platforms/83xx/mpc832x_mds.c |    5 +----
> arch/powerpc/platforms/83xx/mpc832x_rdb.c |    7 ++-----
> arch/powerpc/platforms/83xx/mpc834x_itx.c |    9 +--------
> arch/powerpc/platforms/83xx/mpc834x_mds.c |    9 +--------
> arch/powerpc/platforms/83xx/mpc836x_mds.c |    5 +----
> arch/powerpc/platforms/83xx/mpc836x_rdk.c |    9 +--------
> arch/powerpc/platforms/83xx/mpc837x_mds.c |   11 +----------
> arch/powerpc/platforms/83xx/mpc837x_rdb.c |   11 +----------
> arch/powerpc/platforms/83xx/mpc83xx.h     |    6 ++++++
> arch/powerpc/platforms/83xx/sbc834x.c     |   10 +---------
> 13 files changed, 34 insertions(+), 80 deletions(-)

applied to next

- k
