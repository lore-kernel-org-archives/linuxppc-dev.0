Return-Path: <paubert@iram.es>
Received: from rudy.puc.rediris.es (rudy.puc.rediris.es
 [IPv6:2001:720:418:ca01::132])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 70FA61A0145
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 20:16:09 +1000 (AEST)
Date: Fri, 25 Sep 2015 11:37:48 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Michael Neuling <mikey@neuling.org>,
 Steve Munroe <sjmunroe@us.ibm.com>, anton@samba.org,
 Aaron Sawdey <sawdey@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/2] powerpc/selftest: Add gettimeofday() benchmark
Message-ID: <20150925093746.GA21535@visitor2.iram.es>
References: <1443153700-15395-1-git-send-email-mikey@neuling.org>
 <1443153700-15395-2-git-send-email-mikey@neuling.org>
 <1474940.LhqZEdbX4W@wuerfel>
 <CAOJe8K2SDPFUXBtPcFUcu9=UwCA1rC2rcHzowSA-b=1G+9+6JA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOJe8K2SDPFUXBtPcFUcu9=UwCA1rC2rcHzowSA-b=1G+9+6JA@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 25, 2015 at 12:28:30PM +0300, Denis Kirjanov wrote:
> On 9/25/15, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Friday 25 September 2015 14:01:39 Michael Neuling wrote:
> >> This adds a benchmark directory to the powerpc selftests and adds a
> >> gettimeofday() benchmark to it.
> >>
> >> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> >> Signed-off-by: Michael Neuling <mikey@neuling.org>
> >>
> >
> > Any reason for keeping this powerpc specific? It seems generally useful.
> > and portable.
> You're right. Moreover, we can put some comment to the benchmark why
> we've made such decision to add it (reference to the commit
> "powerpc/vdso: Avoid link stack corruption in __get_datapage()")

Why gettimeofday? Isn't clock_gettime the modern variant?

BTW: dows anyone receive 2 copies of every messge in this thread ?

I do, and I suspect that this is due to the Cc: list having both
linuxppc-dev@ozlabs.org and linuxppc-dev@lists.ozlabs.org. I removed the
former for this reply.

    Gabriel
