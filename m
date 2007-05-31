Return-Path: <m.kozlowski@tuxland.pl>
Received: from tuxland.pl (xdsl-664.zgora.dialog.net.pl [81.168.226.152])
	by ozlabs.org (Postfix) with ESMTP id 52DFEDDF3E
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Jun 2007 06:43:22 +1000 (EST)
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@ozlabs.org,
	paulus@samba.org, Arnd Bergmann <arndb@de.ibm.com>
Subject: Re: 2.6.22-rc3-mm1
Date: Thu, 31 May 2007 22:43:18 +0200
References: <20070530235823.793f00d9.akpm@linux-foundation.org>
In-Reply-To: <20070530235823.793f00d9.akpm@linux-foundation.org>
MIME-Version: 1.0
Message-Id: <200705312243.18724.m.kozlowski@tuxland.pl>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello

	This is from iMac G3. The spufs_mem_mmap_fault() code looks bad
in arch/powerpc/platforms/cell/spufs/file.c but somehow I'm unable to find
the patch to blame hmm.

arch/powerpc/platforms/cell/spufs/file.c: In function 'spufs_mem_mmap_fault':
arch/powerpc/platforms/cell/spufs/file.c:122: error: 'address' undeclared (first use in this function)
arch/powerpc/platforms/cell/spufs/file.c:122: error: (Each undeclared identifier is reported only once
arch/powerpc/platforms/cell/spufs/file.c:122: error: for each function it appears in.)
arch/powerpc/platforms/cell/spufs/file.c:141: error: expected ';' before 'if'
arch/powerpc/platforms/cell/spufs/file.c:122: warning: unused variable 'addr0'
make[3]: *** [arch/powerpc/platforms/cell/spufs/file.o] Blad 1
make[2]: *** [arch/powerpc/platforms/cell/spufs] Blad 2
make[1]: *** [arch/powerpc/platforms/cell] Blad 2

Regards,

	Mariusz
