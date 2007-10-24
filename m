Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id 4B181DDF11
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Oct 2007 06:46:19 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so405884wag
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Oct 2007 13:46:17 -0700 (PDT)
Message-ID: <fa686aa40710241346j4229f72kb4455f6ff8711c44@mail.gmail.com>
Date: Wed, 24 Oct 2007 14:46:17 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Matt Mackall" <mpm@selenic.com>
Subject: Re: Apparent kernel bug with GDB on ppc405
In-Reply-To: <20071024204215.GC19691@waste.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071024194640.GB19691@waste.org>
	<fa686aa40710241328x77435cc1lf09cac730b0ce5ac@mail.gmail.com>
	<20071024204215.GC19691@waste.org>
Cc: gdb@sourceware.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 10/24/07, Matt Mackall <mpm@selenic.com> wrote:
> On Wed, Oct 24, 2007 at 02:28:14PM -0600, Grant Likely wrote:
> > On 10/24/07, Matt Mackall <mpm@selenic.com> wrote:
> > > I'm trying to debug a trivial statically-linked hello world program on
> > > a Xilinx PPC 405 and I'm seeing the following behavior:
> > >
> > <snip>
> > >
> > > Any suggestions?
> >
> > http://thread.gmane.org/gmane.linux.ports.ppc.embedded/11202
> >
> > I was fighting with a similar problem almost 2 years ago.  Looks like
> > it might be related.  At some point the problem seemed to go away and
> > I determined what the root cause was.  :-(
> >
> > I haven't been using gdb lately, so I don't know if it's the same
> > problem.  Nobody I had talked to had seen the issue on other 405
> > platforms.  It could very well be something virtex-specific.
>
> Could be the same problem, but I'm seeing only your symptom 3 so far.
>
> I've tried throwing some larger hammers at the problem. Flushing all
> of the dcache and icache (flush_dcache_all and
> flush_instruction_cache) isn't helping. But printk(".") does!

It's really true; printk *is* the most valuable tool kernel hackers
have for debugging.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
