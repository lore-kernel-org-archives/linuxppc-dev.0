Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6A3251007DD
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 15:42:01 +1000 (EST)
Subject: Re: [PATCH] powerpc/mpc8610_hpcd: Do not use "/" in interrupt names
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <alpine.DEB.2.00.1105041627560.2601@ayla.of.borg>
Date: Thu, 19 May 2011 00:41:47 -0500
Message-Id: <914167DB-90BD-4ABA-B305-84918FA14BF9@kernel.crashing.org>
References: <alpine.DEB.2.00.1105041627560.2601@ayla.of.borg>
To: Geert Uytterhoeven <geert@linux-m68k.org>
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


On May 4, 2011, at 9:29 AM, Geert Uytterhoeven wrote:

> It may trigger a warning in fs/proc/generic.c:__xlate_proc_name() when
> trying to add an entry for the interrupt handler to sysfs.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> arch/powerpc/platforms/86xx/mpc8610_hpcd.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

applied to next, will CC for stable (2.6.39.1)

- k
