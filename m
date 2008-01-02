Return-Path: <compudj@krystal.dyndns.org>
Received: from tomts5-srv.bellnexxia.net (tomts5-srv.bellnexxia.net
	[209.226.175.25]) by ozlabs.org (Postfix) with ESMTP id 33C17DDE99
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 04:57:32 +1100 (EST)
Received: from toip4.srvr.bell.ca ([209.226.175.87])
	by tomts5-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20080102175729.CHIY17217.tomts5-srv.bellnexxia.net@toip4.srvr.bell.ca>
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Jan 2008 12:57:29 -0500
Date: Wed, 2 Jan 2008 12:47:29 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [2.6.24 patch] Fix Cell OProfile support
Message-ID: <20080102174729.GC2189@Krystal>
References: <20071228185649.GC4738@stusta.de> <20071229160921.GB12262@Krystal>
	<200712311710.08869.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200712311710.08869.arnd@arndb.de>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, phil.el@wanadoo.fr,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, oprofile-list@lists.sourceforge.net,
	Adrian Bunk <adrian.bunk@movial.fi>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Arnd Bergmann (arnd@arndb.de) wrote:
> On Saturday 29 December 2007, Mathieu Desnoyers wrote:
> > This patch restores the Cell OProfile support that was killed by
> > commit 09cadedbdc01f1a4bea1f427d4fb4642eaa19da9.
> > 
> > It puts it in arch/powerpc/Kconfig. Since I don't see any good reason to leave
> > this as a supplementary user-selectable option, it is now automatically enabled
> > whenever SPU_FS and OPROFILE are enabled.
> 
> This one has already been superceded by the fix in 
> aed3a8c9bb1a8623a618232087c5ff62718e3b9a, which made CONFIG_OPROFILE_CELL an
> automatically selected option, from arch/powerpc/platforms/cell/Kconfig.
> 

Great, so my patch should be dropped. Thanks!

Mathieu

> 	Arnd <><
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Mathieu Desnoyers
Computer Engineering Ph.D. Student, Ecole Polytechnique de Montreal
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
