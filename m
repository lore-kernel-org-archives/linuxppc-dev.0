Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:1c35:abcd:42:0:1])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3F1D1B7025
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2012 08:48:28 +1100 (EST)
Date: Thu, 29 Mar 2012 23:48:07 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [GIT PULL] Disintegrate and kill asm/system.h
In-Reply-To: <CACxGe6v+nMMuEM+bBMdYf_OeuaXb+NsS0qz-+puRtdzHLPH2hA@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1203292344140.2542@ionos>
References: <5599.1332958811@redhat.com> <30702.1332989444@neuling.org>
 <20120329135555.06593144b65bf81cc9191f8a@canb.auug.org.au>
 <20120329151544.ef2117821dfb459e8b52af48@canb.auug.org.au>
 <CA+55aFzn=bsH76hPDUgS-FBP=RVu51gwmRdqjkw5RJO=Q_cRfA@mail.gmail.com>
 <20120329154238.1ce219f7c998da45452af4b2@canb.auug.org.au>
 <CA+55aFzjQ7qb=bPAj_gGoGLPXOGweTaqtmOBZH4mUt8E_KQwsg@mail.gmail.com>
 <1333008684.3010.9.camel@pasglop>
 <CACxGe6v+nMMuEM+bBMdYf_OeuaXb+NsS0qz-+puRtdzHLPH2hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-arch@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 Michael Neuling <mikey@neuling.org>, arnd@arndb.de,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel@vger.kernel.org,
 David Howells <dhowells@redhat.com>, paul.gortmaker@windriver.com,
 hpa@zytor.com, akpm@linux-foundation.org,
 Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 29 Mar 2012, Grant Likely wrote:
> On Thu, Mar 29, 2012 at 2:11 AM, Benjamin Herrenschmidt
> The rightmost fields of /proc/interrupts are a weird set of
> conditional outputs that don't really have any parsable formatting to
> them.  It may be safe to apply my patch because it adds another field
> in the middle of a section of conditional outputs* anyway so tools
> already won't know what those fields mean.  But, regardless, I'm not
> going to take responsibility for applying that patch unless encouraged
> by several other maintainers to do so.

Go ahead. We changed that output several times in the last years
without causing the end of the universe.

Thanks,

	tglx
