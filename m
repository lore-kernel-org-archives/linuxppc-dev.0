Return-Path: <dhowells@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 11EAC1A0174
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 01:57:19 +1100 (AEDT)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20160127083546.GJ6357@twins.programming.kicks-ass.net>
References: <20160127083546.GJ6357@twins.programming.kicks-ass.net>
 <5696BA6E.4070508@imgtec.com> <20160114120445.GB15828@arm.com>
 <56980145.5030901@imgtec.com> <20160114204827.GE3818@linux.vnet.ibm.com>
 <56981212.7050301@imgtec.com> <20160114222046.GH3818@linux.vnet.ibm.com>
 <20160126102402.GE6357@twins.programming.kicks-ass.net>
 <20160126103200.GI6375@twins.programming.kicks-ass.net>
 <20160126110053.GA21553@arm.com> <20160126201143.GV4503@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: dhowells@redhat.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Will Deacon <will.deacon@arm.com>,
 Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Russell King - ARM Linux <linux@arm.linux.org.uk>,
 virtualization@lists.linux-foundation.org,
 Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
 "H. Peter Anvin" <hpa@zytor.com>, Joe Perches <joe@perches.com>,
 David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org,
 user-mode-linux-devel@lists.sourceforge.net,
 adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org,
 Ralf Baechle <ralf@linux-mips.org>, Ingo Molnar <mingo@kernel.org>,
 ddaney.cavm@gmail.com, james.hogan@imgtec.com,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] documentation: Add disclaimer
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 27 Jan 2016 14:57:07 +0000
Message-ID: <15882.1453906627@warthog.procyon.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Peter Zijlstra <peterz@infradead.org> wrote:

> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +DISCLAIMER
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This document is not a specification; it is intentionally (for the sake=
 of
> +brevity) and unintentionally (due to being human) incomplete. This docu=
ment is
> +meant as a guide to using the various memory barriers provided by Linux=
, but
> +in case of any doubt (and there are many) please ask.
> +
> +I repeat, this document is not a specification of what Linux expects fr=
om
> +hardware.

The purpose of this document is twofold:

 (1) to specify the minimum functionality that one can rely on for any
     particular barrier, and

 (2) to provide a guide as to how to use the barriers that are available.

Note that an architecture can provide more than the minimum requirement fo=
r
any particular barrier, but if the barrier provides less than that, it is
incorrect.

Note also that it is possible that a barrier may be a no-op for an
architecture because the way that arch works renders an explicit barrier
unnecessary in that case.

> +

Can you bung an extra blank line in here if you have to redo this at all?

> +=3D=3D=3D=3D=3D=3D=3D=3D
> +CONTENTS
> +=3D=3D=3D=3D=3D=3D=3D=3D
>  =

>   (*) Abstract memory access model.
>  =


David
