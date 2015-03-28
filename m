Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6AEAF1A0260
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 21:40:03 +1100 (AEDT)
Message-ID: <1427539202.7547.0.camel@ellerman.id.au>
Subject: Re: [PATCH v4 2/2] selftests/powerpc: Add a test of the
 switch_endian() syscall
From: Michael Ellerman <mpe@ellerman.id.au>
To: Gabriel Paubert <paubert@iram.es>
Date: Sat, 28 Mar 2015 21:40:02 +1100
In-Reply-To: <20150328091705.GC4500@visitor2.iram.es>
References: <1427505550-13252-1-git-send-email-mpe@ellerman.id.au>
 <1427505550-13252-2-git-send-email-mpe@ellerman.id.au>
 <20150328091705.GC4500@visitor2.iram.es>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Jeremy Kerr <jk@ozlabs.org>,
 khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2015-03-28 at 10:17 +0100, Gabriel Paubert wrote:
> On Sat, Mar 28, 2015 at 12:19:10PM +1100, Michael Ellerman wrote:
> > This adds a test of the switch_endian() syscall we added in the previous
> > commit.

...

> > +
> > +	/* r9 - r12 are clobbered */
> > +
> > +	addi	r13, r15, 13
> > +	addi	r14, r15, 14
> > +
> > +	/* Skip r15 we're using it */
> > +
> > +	addi	r16, r15, 16
> > +	addi	r16, r15, 16
> 
> Duplicate?
 
Oh god damn it.

Yes :)

Thanks for reviewing.

cheers
