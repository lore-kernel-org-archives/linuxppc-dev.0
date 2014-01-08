Return-Path: <michael@ellerman.id.au>
Message-ID: <1389154699.2076.6.camel@concordia>
Subject: Re: [PATCH] powerpc: add vr save/restore functions
From: Michael Ellerman <michael@ellerman.id.au>
To: Andreas Schwab <schwab@linux-m68k.org>
Date: Wed, 08 Jan 2014 15:18:19 +1100
In-Reply-To: <87eh4uif62.fsf@igel.home>
References: <87eh4uif62.fsf@igel.home>
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

On Mon, 2013-12-30 at 15:31 +0100, Andreas Schwab wrote:
> GCC 4.8 now generates out-of-line vr save/restore functions when
> optimizing for size.  They are needed for the raid6 altivec support.

It looks like they're identical for 32 & 64-bit ? If so can't we arrange to
have a single version?

cheers
