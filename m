Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 11FD8DDF39
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 11:45:59 +1100 (EST)
Date: Fri, 25 Jan 2008 15:19:40 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 1/5] [POWERPC] qe_lib and users: get rid of most
	device_types and model
In-Reply-To: <20080124153959.GA23246@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0801251519190.20972@blarg.am.freescale.net>
References: <20080124151850.GA15190@localhost.localdomain>
	<20080124153959.GA23246@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 24 Jan 2008, Anton Vorontsov wrote:

> Now we're searching for "fsl,qe", "fsl,qe-muram", "fsl,qe-muram-data"
> and "fsl,qe-ic".
>
> Unfortunately it's still impossible to remove device_type = "qe"
> from the existing device trees (except for MPC8360E-RDK), because
> older u-boots are looking for it.
>
> Per http://ozlabs.org/pipermail/linuxppc-dev/2007-December/048388.html
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  Documentation/powerpc/booting-without-of.txt |   11 +++--
>  arch/powerpc/boot/dts/mpc832x_mds.dts        |    9 ++--
>  arch/powerpc/boot/dts/mpc832x_rdb.dts        |   10 +++--
>  arch/powerpc/boot/dts/mpc836x_mds.dts        |   10 +++--
>  arch/powerpc/boot/dts/mpc836x_rdk.dts        |    1 -
>  arch/powerpc/boot/dts/mpc8568mds.dts         |   10 +++--
>  arch/powerpc/platforms/83xx/mpc832x_mds.c    |   11 +++--
>  arch/powerpc/platforms/83xx/mpc832x_rdb.c    |   11 +++--
>  arch/powerpc/platforms/83xx/mpc836x_mds.c    |   11 +++--
>  arch/powerpc/platforms/85xx/mpc85xx_mds.c    |   32 ++++++++-----
>  arch/powerpc/sysdev/fsl_soc.c                |    5 ++-
>  arch/powerpc/sysdev/qe_lib/qe.c              |   63 ++++++++++++++++++--------
>  12 files changed, 117 insertions(+), 67 deletions(-)
>

applied, however _rdk will need fixing.

- k
