Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B368FB713A
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Sep 2010 07:40:34 +1000 (EST)
Subject: Re: [PATCH] powerpc/85xx: Fix compile issue with p1022_ds due to lmb
	rename to memblock
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1283272943-2454-1-git-send-email-galak@kernel.crashing.org>
Date: Tue, 31 Aug 2010 16:40:17 -0500
Message-Id: <3CD62C9C-C146-4988-8E7F-062B6FB540C0@kernel.crashing.org>
References: <1283272943-2454-1-git-send-email-galak@kernel.crashing.org>
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


On Aug 31, 2010, at 11:42 AM, Kumar Gala wrote:

> arch/powerpc/platforms/85xx/p1022_ds.c:22:23: error: linux/lmb.h: No =
such file or directory
> arch/powerpc/platforms/85xx/p1022_ds.c: In function =
'p1022_ds_setup_arch':
> arch/powerpc/platforms/85xx/p1022_ds.c:100: error: implicit =
declaration of function 'memblock_end_of_DRAM'
> arch/powerpc/platforms/85xx/p1022_ds.c: At top level:
> arch/powerpc/platforms/85xx/p1022_ds.c:147: error: 'udbg_progress' =
undeclared here (not in a function)
> make[2]: *** [arch/powerpc/platforms/85xx/p1022_ds.o] Error 1
>=20
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/platforms/85xx/p1022_ds.c |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)

applied to merge

- k=
