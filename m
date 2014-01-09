Return-Path: <michael@ellerman.id.au>
Message-ID: <1389226195.25505.3.camel@concordia>
Subject: Re: [PATCH] powerpc: add vr save/restore functions
From: Michael Ellerman <michael@ellerman.id.au>
To: Andreas Schwab <schwab@linux-m68k.org>
Date: Thu, 09 Jan 2014 11:09:55 +1100
In-Reply-To: <87fvoypznh.fsf@igel.home>
References: <87eh4uif62.fsf@igel.home> <1389154699.2076.6.camel@concordia>
 <87fvoypznh.fsf@igel.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-01-08 at 10:54 +0100, Andreas Schwab wrote:
> Michael Ellerman <michael@ellerman.id.au> writes:
> 
> > On Mon, 2013-12-30 at 15:31 +0100, Andreas Schwab wrote:
> >> GCC 4.8 now generates out-of-line vr save/restore functions when
> >> optimizing for size.  They are needed for the raid6 altivec support.
> >
> > It looks like they're identical for 32 & 64-bit ?
> 
> They use different temporary registers and calling conventions (no .opd
> for ppc64).

Yeah, sorry, you'd think I could spot the difference between r11 and r12.

cheers
