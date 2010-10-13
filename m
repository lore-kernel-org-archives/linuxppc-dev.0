Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 680011007D2
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 09:03:44 +1100 (EST)
Subject: Re: [PATCH v4 1/5] powerpc/fsl-booke: Add support for FSL 64-bit
	e5500 core
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1287007333-4436-1-git-send-email-galak@kernel.crashing.org>
Date: Wed, 13 Oct 2010 17:03:38 -0500
Message-Id: <F31A6A48-34A9-43A7-A037-9E991F8DC712@kernel.crashing.org>
References: <1287007333-4436-1-git-send-email-galak@kernel.crashing.org>
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


On Oct 13, 2010, at 5:02 PM, Kumar Gala wrote:

> The new e5500 core is similar to the e500mc core but adds 64-bit
> support.  We support running it in 32-bit mode as it is identical to =
the
> e500mc.
>=20
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> * Further kconfig cleanup
>=20
> arch/powerpc/kernel/Makefile              |    4 +++-
> arch/powerpc/kernel/cpu_setup_fsl_booke.S |   15 +++++++++++++++
> arch/powerpc/kernel/cputable.c            |   28 =
+++++++++++++++++++++++++++-
> arch/powerpc/kernel/traps.c               |    5 +++++
> arch/powerpc/platforms/85xx/Kconfig       |    5 ++++-
> arch/powerpc/platforms/Kconfig.cputype    |    8 +++++++-
> 6 files changed, 61 insertions(+), 4 deletions(-)

ignore the 1/5 and 4/5 that was a git format-patch foobar.

- k=
