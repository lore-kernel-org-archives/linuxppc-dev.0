Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
	[213.199.154.141])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E67CEB6F19
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 10 May 2011 02:24:29 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] powerpc/mpc8610_hpcd: Do not use "/" in interrupt names
Date: Mon, 9 May 2011 16:09:10 +0000
Message-ID: <BANLkTi=ytcPhpYp=Mqk7fYYAv+5eqbkNww@mail.gmail.com>
References: <alpine.DEB.2.00.1105041627560.2601@ayla.of.borg>
In-Reply-To: <alpine.DEB.2.00.1105041627560.2601@ayla.of.borg>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: Anton Vorontsov <avorontsov@ru.mvista.com>,
	Linux/PPC Development <linuxppc-dev@lists.ozlabs.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 4, 2011 at 9:29 AM, Geert Uytterhoeven <geert@linux-m68k.org> w=
rote:
> It may trigger a warning in fs/proc/generic.c:__xlate_proc_name() when
> trying to add an entry for the interrupt handler to sysfs.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: Timur Tabi <timur@freescale.com>

This fixes a real bug in the kernel.

--=20
Timur Tabi
Linux kernel developer at Freescale=
