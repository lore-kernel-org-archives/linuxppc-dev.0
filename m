Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17274.61005.845301.27856@cargo.ozlabs.ibm.com>
Date: Wed, 16 Nov 2005 19:31:09 +1100
From: Paul Mackerras <paulus@samba.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20051116082456.GA24802@lst.de>
References: <17274.51251.591579.8751@cargo.ozlabs.ibm.com>
	<20051116082456.GA24802@lst.de>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: powerpc.git tree now on kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christoph Hellwig writes:

> Please make sure at least all patches required to kill arch/ppc64 and
> include/asm-ppc64 go to Linus.  If 2.6.15 released with the include3
> hack that would mean endless pain to people building external modules
> and the distributions trying to support that.

Yes, that is my intention.  For 2.6.15, at this stage, some of the
header files might end up looking like:

#ifdef CONFIG_PPC32
#include <asm-ppc/foo.h>
#else
/* contents of asm-ppc64/foo.h */
#endif

if it looks like doing a proper merge will require too many changes.
But at least it gets the files out of include/asm-ppc64.

Paul.
