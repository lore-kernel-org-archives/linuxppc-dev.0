Return-Path: <michael@ellerman.id.au>
Date: Wed, 6 Mar 2013 15:09:50 +1100
From: Michael Ellerman <michael@ellerman.id.au>
To: Christian Kujau <lists@nerdbynature.de>
Subject: Re: [PATCH] ppc32: Fix compile of sha1-powerpc-asm.S
Message-ID: <20130306040950.GC3493@concordia>
References: <1361845205-30606-1-git-send-email-tony@bakeyournoodle.com>
 <alpine.DEB.2.10.1303041656010.22410@trent.utfs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.10.1303041656010.22410@trent.utfs.org>
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 04, 2013 at 05:23:14PM -0800, Christian Kujau wrote:
> On Tue, 26 Feb 2013 at 13:20, Tony Breeds wrote:
> > When building with CRYPTO_SHA1_PPC enabled we fail with:
> > ---
> > powerpc/crypto/sha1-powerpc-asm.S: Assembler messages:
> > powerpc/crypto/sha1-powerpc-asm.S:116: Error: can't resolve `0' {*ABS* section} - `STACKFRAMESIZE' {*UND* section}
> > powerpc/crypto/sha1-powerpc-asm.S:116: Error: expression too complex
> > powerpc/crypto/sha1-powerpc-asm.S:178: Error: unsupported relocation against STACKFRAMESIZE
> > ---
> > 
> > Use INT_FRAME_SIZE instead.
> > 
> > Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
> 
> Thanks for the fix! Ran into this as well, with your patch 3.9-rc1 
> compiles again (and it even boots :-))
> 
> Tested-by: Christian Kujau <lists@nerdbynature.de>
> 
> $ grep -A10 sha1 /proc/crypto
> name         : sha1
> driver       : sha1-powerpc
> module       : kernel
> priority     : 0
> refcnt       : 1
> selftest     : passed
> type         : shash
> blocksize    : 64
> digestsize   : 20

Thanks Christian. What hardware are you on?

cheers
