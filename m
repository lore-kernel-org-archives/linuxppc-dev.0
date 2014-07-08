Return-Path: <xerofoify@gmail.com>
Received: from mail-ve0-x232.google.com (mail-ve0-x232.google.com
 [IPv6:2607:f8b0:400c:c01::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9AC151A0010
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jul 2014 13:13:25 +1000 (EST)
Received: by mail-ve0-f178.google.com with SMTP id oy12so5141284veb.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Jul 2014 20:13:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1404788634.16156.38.camel@pasglop>
References: <CAPDOMVi5ptjaKzT+Exd3XtKcy7W7nNZYUD+MEwN8LmhPrQTZBQ@mail.gmail.com>
 <1404788634.16156.38.camel@pasglop>
Date: Mon, 7 Jul 2014 23:13:22 -0400
Message-ID: <CAPDOMVjg7ks=+LuzS7KAkkVnuRQEL8RxPZQR6sCwZwb56Nxnpw@mail.gmail.com>
Subject: Fwd: Allyesconfig for powerpc still Failing
From: Nick Krause <xerofoify@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: mahesh <mahesh@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Michael Ellerman <michael@ellerman.id.au>, paulus@samba.org,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 On Mon, Jul 7, 2014 at 11:03 PM wrote Benjamin Herrenschmidt

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

If you need any help with these issues please let me known.
Cheers Nick :)
