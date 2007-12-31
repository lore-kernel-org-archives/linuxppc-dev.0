Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 7871BDDE42
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jan 2008 03:10:34 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [2.6.24 patch] Fix Cell OProfile support
Date: Mon, 31 Dec 2007 17:10:06 +0100
References: <20071228185649.GC4738@stusta.de> <20071229160921.GB12262@Krystal>
In-Reply-To: <20071229160921.GB12262@Krystal>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712311710.08869.arnd@arndb.de>
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	phil.el@wanadoo.fr, linux-kernel@vger.kernel.org,
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

On Saturday 29 December 2007, Mathieu Desnoyers wrote:
> This patch restores the Cell OProfile support that was killed by
> commit 09cadedbdc01f1a4bea1f427d4fb4642eaa19da9.
> 
> It puts it in arch/powerpc/Kconfig. Since I don't see any good reason to leave
> this as a supplementary user-selectable option, it is now automatically enabled
> whenever SPU_FS and OPROFILE are enabled.

This one has already been superceded by the fix in 
aed3a8c9bb1a8623a618232087c5ff62718e3b9a, which made CONFIG_OPROFILE_CELL an
automatically selected option, from arch/powerpc/platforms/cell/Kconfig.

	Arnd <><
