From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15870.63843.171445.243166@argo.ozlabs.ibm.com>
Date: Tue, 17 Dec 2002 21:16:03 +1100
To: "Georg Klug" <gklug@giga-stream.de>
Cc: "Tom Rini" <trini@kernel.crashing.org>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: Re: AW: Possible problem in asm/bitops.h
In-Reply-To: <FFECLICFNBJAHONLGAKMAEFOCHAA.gklug@giga-stream.de>
References: <20021212152851.GE19456@opus.bloom.county>
	<FFECLICFNBJAHONLGAKMAEFOCHAA.gklug@giga-stream.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Georg Klug writes:

> Oops, I thought, that the directories /usr/include/linux as well as
> /usr/include/asm should come directly from the kernel (either as a copy

That is how it used to be done, but that way of doing things has been
deprecated for a long time now.  /usr/include/{linux,asm} are part of
glibc these days.

> or symbolically linked). In that case those include files should always
> be prepared to be included in a userland application. Am I right with this?
>
> I also thought, that the asm-ppc/bitops.h should provide the same
> functionality as its pendant in asm-i386/ which lets userland applications
> use some static inline functions like set_bit() clear_bit() and change_bit().
> I actually don't know whether those functions are needed outside the kernel,
> so I cannot tell whether it is correct or not. But IMO it should be done
> the same way on all plattforms. Would you agree?

The policy is the same on all architectures: userland programs should
not include kernel headers.  The architectures differ in the extent to
which this is enforced, that's all.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
