Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17551.20066.365036.256580@cargo.ozlabs.ibm.com>
Date: Wed, 14 Jun 2006 09:46:42 +1000
From: Paul Mackerras <paulus@samba.org>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: 32 bit userland on G5
In-Reply-To: <1150241510.11159.159.camel@shinybook.infradead.org>
References: <1150194348.9208.33.camel@johannes>
	<1150202709.12423.21.camel@hades.cambridge.redhat.com>
	<17551.16830.186314.247458@cargo.ozlabs.ibm.com>
	<1150241510.11159.159.camel@shinybook.infradead.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse writes:

> 'Historical' being until about 4 years ago, around the time of
> http://ecos.sourceware.org/ml/binutils/2002-05/msg00097.html ?

That's not the one I was talking about; that appears to be about
marking the GOT and PLT as executable in the ELF file.  That may be
enough in fact to allow us to turn off read-implies-exec, though.

> We already did it in Fedora. We don't default to READ_IMPLIES_EXEC for
> 32-bit processes on the 64-bit kernel.

By patching include/asm-powerpc/elf.h?

Paul.
