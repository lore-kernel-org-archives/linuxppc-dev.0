Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by ozlabs.org (Postfix) with ESMTP id 9B61ADDE35
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Oct 2007 06:28:15 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so399994wag
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Oct 2007 13:28:15 -0700 (PDT)
Message-ID: <fa686aa40710241328x77435cc1lf09cac730b0ce5ac@mail.gmail.com>
Date: Wed, 24 Oct 2007 14:28:14 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Matt Mackall" <mpm@selenic.com>
Subject: Re: Apparent kernel bug with GDB on ppc405
In-Reply-To: <20071024194640.GB19691@waste.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071024194640.GB19691@waste.org>
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
> I'm trying to debug a trivial statically-linked hello world program on
> a Xilinx PPC 405 and I'm seeing the following behavior:
>
<snip>
>
> Any suggestions?

http://thread.gmane.org/gmane.linux.ports.ppc.embedded/11202

I was fighting with a similar problem almost 2 years ago.  Looks like
it might be related.  At some point the problem seemed to go away and
I determined what the root cause was.  :-(

I haven't been using gdb lately, so I don't know if it's the same
problem.  Nobody I had talked to had seen the issue on other 405
platforms.  It could very well be something virtex-specific.

That's not much help, but maybe it will give you some clues.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
