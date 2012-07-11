Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 12DA82C020E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 22:57:58 +1000 (EST)
Subject: Re: [PATCH v2 2/3] powerpc/e500: add paravirt QEMU platform
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1341966409-22660-3-git-send-email-scottwood@freescale.com>
Date: Wed, 11 Jul 2012 07:57:52 -0500
Message-Id: <B1193B25-B4B5-4842-B9FB-CB1DCBEDC312@kernel.crashing.org>
References: <1341966409-22660-1-git-send-email-scottwood@freescale.com>
 <1341966409-22660-3-git-send-email-scottwood@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 10, 2012, at 7:26 PM, Scott Wood wrote:

> This gives the kernel a paravirtualized machine to target, without
> requiring both sides to pretend to be targeting a specific board
> that likely has little to do with the host in KVM scenarios.  This
> avoids the need to add new boards to QEMU just to be able to
> run KVM on new CPUs.
>=20
> As this is the first platform that can run with either e500v2 or
> e500mc, CONFIG_PPC_E500MC is now a legitimately user configurable
> option, so add a help text.
>=20
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> v2: Added a comment about the flexible nature of this platform, and
> rebased on Kumar's next
>=20
> arch/powerpc/platforms/85xx/Kconfig     |   16 +++++++
> arch/powerpc/platforms/85xx/Makefile    |    1 +
> arch/powerpc/platforms/85xx/qemu_e500.c |   72 =
+++++++++++++++++++++++++++++++
> arch/powerpc/platforms/Kconfig.cputype  |    4 ++
> 4 files changed, 93 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/platforms/85xx/qemu_e500.c

applied to next

- k=
