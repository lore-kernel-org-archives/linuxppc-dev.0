Return-Path: <SRS0+6105dbd9161d2ec1e3ac+1580+infradead.org+hch@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6DF72DDEB7
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 18:12:45 +1100 (EST)
Date: Fri, 21 Dec 2007 07:12:29 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH -mm 18/43] powerpc compat_binfmt_elf
Message-ID: <20071221071229.GC4345@infradead.org>
References: <20071220115200.C767E26F98A@magilla.localdomain>
	<20071220115816.504CC26F98E@magilla.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071220115816.504CC26F98E@magilla.localdomain>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 20, 2007 at 03:58:16AM -0800, Roland McGrath wrote:
> +obj-$(CONFIG_PPC64)		+= ../../../fs/compat_binfmt_elf.o

Building files from another directory is nasty.  Please add a
CONFIG_BINFMT_COMPAT_ELF so we can simply build it in fs/
