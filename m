Return-Path: <m.kozlowski@tuxland.pl>
Received: from tuxland.pl (xdsl-664.zgora.dialog.net.pl [81.168.226.152])
	by ozlabs.org (Postfix) with ESMTP id E990EDDFA4
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 07:29:08 +1100 (EST)
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Andrew Morton <akpm@linux-foundation.org>, Bernhard Walle <bwalle@suse.de>
Subject: Re: 2.6.24-mm1: ppc32: too few arguments to function 'reserve_bootmem'
Date: Mon, 4 Feb 2008 21:29:02 +0100
References: <20080203171634.58ab668b.akpm@linux-foundation.org>
In-Reply-To: <20080203171634.58ab668b.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802042129.03065.m.kozlowski@tuxland.pl>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

	This is from ppc32:

  CC      arch/powerpc/mm/mem.o
arch/powerpc/mm/mem.c: In function 'do_init_bootmem':
arch/powerpc/mm/mem.c:256: error: too few arguments to function 'reserve_bootmem'
arch/powerpc/mm/mem.c:261: error: too few arguments to function 'reserve_bootmem'

Leftover from introduce-flags-for-reserve_bootmem.patch?

Regards,

	Mariusz
