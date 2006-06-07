Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17543.18414.871090.185796@cargo.ozlabs.ibm.com>
Date: Thu, 8 Jun 2006 07:41:02 +1000
From: Paul Mackerras <paulus@samba.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 2/3] powerpc: Implement support for setting little-endian
	mode via prctl
In-Reply-To: <20060607173320.GB5661@pb15.lixom.net>
References: <17542.28368.426967.127506@cargo.ozlabs.ibm.com>
	<20060607173320.GB5661@pb15.lixom.net>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson writes:

> >  #define CPU_FTR_LOCKLESS_TLBIE		ASM_CONST(0x0)
> >  #define CPU_FTR_MMCRA_SIHV		ASM_CONST(0x0)
> >  #define CPU_FTR_CI_LARGE_PAGE		ASM_CONST(0x0)
> > +#define CPU_FTR_PAUSE_ZERO              ASM_CONST(0x0)
> >  #define CPU_FTR_PURR			ASM_CONST(0x0)
> >  #endif
> 
> This seems to have snuck in from something else. It's not used anywhere.

Yes, early on I noticed that this one was missing from the dummy
definitions for 32-bit and cleaned it up as I went past.  I'll remove
that hunk.

Paul.
