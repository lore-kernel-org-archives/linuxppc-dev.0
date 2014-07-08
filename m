Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C81DE1A019B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jul 2014 13:04:19 +1000 (EST)
Message-ID: <1404788634.16156.38.camel@pasglop>
Subject: Re: Allyesconfig for powerpc still Failing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nick Krause <xerofoify@gmail.com>
Date: Tue, 08 Jul 2014 13:03:54 +1000
In-Reply-To: <CAPDOMVi5ptjaKzT+Exd3XtKcy7W7nNZYUD+MEwN8LmhPrQTZBQ@mail.gmail.com>
References: <CAPDOMVi5ptjaKzT+Exd3XtKcy7W7nNZYUD+MEwN8LmhPrQTZBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: mahesh@linux.vnet.ibm.com, agraf@suse.de,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 michael@ellerman.id.au, paulus@samba.org, anton@samba.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-07-07 at 22:45 -0400, Nick Krause wrote:
> Today I tested the allyesconfig for powerpc and it seems to be still
> failing according to my tests.
> Below are the error messages I get before the jobs finish and exit
> failing the build.
> Cheers Nick
> arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
> arch/powerpc/kernel/exceptions-64s.S:1331: Error: attempt to move .org backwards
> make[1]: *** [arch/powerpc/kernel/head_64.o] Error 1
> make: *** [arch/powerpc/kernel] Error 2
> make: *** Waiting for unfinished jobs....

Yes, it's a trainwreck and I don't know how to fix it yet ... I tried
various more or less invasive approaches and none of them worked
properly so far. I need to spend more time on this.

Cheers,
Ben.
