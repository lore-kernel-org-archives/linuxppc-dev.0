Return-Path: <michael@ellerman.id.au>
Message-ID: <1387856093.15093.3.camel@concordia>
Subject: Re: [PATCH] powerpc: Make 64-bit non-VMX __copy_tofrom_user bi-endian
From: Michael Ellerman <michael@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>
Date: Tue, 24 Dec 2013 14:34:53 +1100
In-Reply-To: <20131224120259.454bc44c@kryten>
References: <20131218092957.4a12cbcf@kryten>
 <20131218211502.034c3eb0@kryten> <1387459057.1305.1.camel@concordia>
 <20131224120259.454bc44c@kryten>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paulmck@linux.vnet.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-12-24 at 12:02 +1100, Anton Blanchard wrote:
> Hi Michael,
> 
> > > To try and catch any screw ups in our ppc64 memcpy and
> > > copy_tofrom_user loops, I wrote a quick test:
> > > 
> > > http://ozlabs.org/~anton/junkcode/validate_kernel_copyloops.tar.gz
> > 
> > Nice! How's this look?
> 
> Love it!

Cool, I'll add your Signed-off-by and resubmit.

> At the moment my other copy_to/from_user tests run against the kernel
> (testing we copy all data right up to a page fault and that we return
> the correct number of bytes not copied etc). A small signal handler
> that walks the exception entries and branches to the handler should be
> all it takes to do it completely in userspace.

That'd be nice. Are they in your junkcode? I couldn't spot them at a glance.

cheers
