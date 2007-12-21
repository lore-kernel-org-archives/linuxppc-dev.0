Return-Path: <roland@redhat.com>
Received: from QMTA06.emeryville.ca.mail.comcast.net
	(qmta06.emeryville.ca.mail.comcast.net [76.96.30.56])
	by ozlabs.org (Postfix) with ESMTP id E28EBDDDEB
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 19:56:42 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH -mm 18/43] powerpc compat_binfmt_elf
In-Reply-To: Christoph Hellwig's message of  Friday,
	21 December 2007 07:12:29 +0000
	<20071221071229.GC4345@infradead.org>
References: <20071220115200.C767E26F98A@magilla.localdomain>
	<20071220115816.504CC26F98E@magilla.localdomain>
	<20071221071229.GC4345@infradead.org>
Message-Id: <20071221085609.4D53B26F98A@magilla.localdomain>
Date: Fri, 21 Dec 2007 00:56:09 -0800 (PST)
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

> On Thu, Dec 20, 2007 at 03:58:16AM -0800, Roland McGrath wrote:
> > +obj-$(CONFIG_PPC64)		+= ../../../fs/compat_binfmt_elf.o
> 
> Building files from another directory is nasty.  Please add a
> CONFIG_BINFMT_COMPAT_ELF so we can simply build it in fs/

If that's better, please post the precise Kconfig magic you have in mind to
have it set when it should be.


Thanks,
Roland
