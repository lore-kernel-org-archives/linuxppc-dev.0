Return-Path: <akpm@osdl.org>
Received: from mail.osdl.org (fw.osdl.org [65.172.181.6])
	by ozlabs.org (Postfix) with ESMTP id 14C642BDF2
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Nov 2004 15:31:13 +1100 (EST)
Date: Mon, 22 Nov 2004 20:24:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Message-Id: <20041122202441.511c055d.akpm@osdl.org>
In-Reply-To: <41A27F77.9080401@mvista.com>
References: <419E6900.5070001@mvista.com>
	<20041119155854.02af2174.akpm@osdl.org>
	<41A27F77.9080401@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][PPC32] Marvell host bridge support (mv64x60)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

"Mark A. Greer" <mgreer@mvista.com> wrote:
>
> Andrew Morton wrote:
> 
>  >Anyway, I'll stick this as-is in -mm.  Feel free to send an incremental
>  >patch, or a replacement.
>  >
> 
>  Here is an incremental patch [hopefully] with your concerns addressed.  

OK, thanks.  I added this to the queue for post-2.6.10.  I'll assume that
silence means assent from the rest of the ppc team ;)

(Patches are at

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm3/broken-out/ppc32-marvell-host-bridge-support-mv64x60.patch
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm3/broken-out/ppc32-support-for-marvell-ev-64260-bp-eval-platform.patch
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm3/broken-out/ppc32-support-for-artesyn-katana-cpci-boards.patch
