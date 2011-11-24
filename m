Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 242B31007D8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 17:40:45 +1100 (EST)
Subject: Re: [PATCH V2 1/3] powerpc/83xx: consolidate init_IRQ functions
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1311364544-9413-2-git-send-email-dbaryshkov@gmail.com>
Date: Thu, 24 Nov 2011 00:40:28 -0600
Message-Id: <EFC96D7D-8DE4-400E-8C13-C2DDDA6AC98E@kernel.crashing.org>
References: <1311364544-9413-1-git-send-email-dbaryshkov@gmail.com>
 <1311364544-9413-2-git-send-email-dbaryshkov@gmail.com>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Linux PPC Development <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 22, 2011, at 2:55 PM, Dmitry Eremin-Solenikov wrote:

> On mpc83xx platform nearly all _init_IRQ functions look alike. They =
either
> just setup ipic, or setup ipic and QE PIC. Separate this to special =
functions
> to be either referenced from ppc_md, or called from board file.
>=20
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
> arch/powerpc/platforms/83xx/asp834x.c     |   20 +------------
> arch/powerpc/platforms/83xx/km83xx.c      |   33 +--------------------
> arch/powerpc/platforms/83xx/misc.c        |   46 =
+++++++++++++++++++++++++++++
> arch/powerpc/platforms/83xx/mpc830x_rdb.c |   18 +----------
> arch/powerpc/platforms/83xx/mpc831x_rdb.c |   18 +----------
> arch/powerpc/platforms/83xx/mpc832x_mds.c |   30 +------------------
> arch/powerpc/platforms/83xx/mpc832x_rdb.c |   31 +-------------------
> arch/powerpc/platforms/83xx/mpc834x_itx.c |   18 +----------
> arch/powerpc/platforms/83xx/mpc834x_mds.c |   18 +----------
> arch/powerpc/platforms/83xx/mpc836x_mds.c |   30 +------------------
> arch/powerpc/platforms/83xx/mpc836x_rdk.c |   28 +-----------------
> arch/powerpc/platforms/83xx/mpc837x_mds.c |   18 +----------
> arch/powerpc/platforms/83xx/mpc837x_rdb.c |   18 +----------
> arch/powerpc/platforms/83xx/mpc83xx.h     |    9 +++++
> arch/powerpc/platforms/83xx/sbc834x.c     |   20 +------------
> 15 files changed, 68 insertions(+), 287 deletions(-)

applied to next

- k=
