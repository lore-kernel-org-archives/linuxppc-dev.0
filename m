Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3E37D1A002B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 11:49:57 +1000 (AEST)
Message-ID: <1443577797.5103.7.camel@ellerman.id.au>
Subject: Re: [PATCH v2 1/2] powerpc/selftest: Add gettimeofday() benchmark
From: Michael Ellerman <mpe@ellerman.id.au>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: Michael Neuling <mikey@neuling.org>, Arnd Bergmann <arnd@arndb.de>,
 Aaron Sawdey <sawdey@us.ibm.com>, Steve Munroe <sjmunroe@us.ibm.com>,
 anton@samba.org,  linuxppc-dev@lists.ozlabs.org
Date: Wed, 30 Sep 2015 11:49:57 +1000
In-Reply-To: <CAOJe8K226iObK=8dMGX+-CYFHzixk-UGeSDYNACGi0Nj37gTXA@mail.gmail.com>
References: <1443153700-15395-1-git-send-email-mikey@neuling.org>
 <1443153700-15395-2-git-send-email-mikey@neuling.org>
 <1474940.LhqZEdbX4W@wuerfel>
 <CAOJe8K2SDPFUXBtPcFUcu9=UwCA1rC2rcHzowSA-b=1G+9+6JA@mail.gmail.com>
 <20150925093746.GA21535@visitor2.iram.es>
 <1443430694.3171.6.camel@neuling.org>
 <CAOJe8K226iObK=8dMGX+-CYFHzixk-UGeSDYNACGi0Nj37gTXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-09-28 at 12:56 +0300, Denis Kirjanov wrote:
> On 9/28/15, Michael Neuling <mikey@neuling.org> wrote:
> > On Fri, 2015-09-25 at 11:37 +0200, Gabriel Paubert wrote:
> >> On Fri, Sep 25, 2015 at 12:28:30PM +0300, Denis Kirjanov wrote:
> >> > On 9/25/15, Arnd Bergmann <arnd@arndb.de> wrote:
> >> > > On Friday 25 September 2015 14:01:39 Michael Neuling wrote:
> >> > >> This adds a benchmark directory to the powerpc selftests and adds a
> >> > >> gettimeofday() benchmark to it.
> >> > >>
> >> > >> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> >> > >> Signed-off-by: Michael Neuling <mikey@neuling.org>
> >> > >>
> >> > >
> >> > > Any reason for keeping this powerpc specific? It seems generally
> >> > > useful.
> >> > > and portable.
> >> > You're right. Moreover, we can put some comment to the benchmark why
> >> > we've made such decision to add it (reference to the commit
> >> > "powerpc/vdso: Avoid link stack corruption in __get_datapage()")
> >>
> >> Why gettimeofday? Isn't clock_gettime the modern variant?
> >
> > We can do either here really.  I just wanted to test __get_datapage()
> > really.  I just stole the benchmark from Anton, which turned into mpe
> > wanting it in selftests.  I dumped it in powerpc mostly because I knew
> > mpe would take it (ie. I'm was being lazy).
> 
> Yeah, so the quickest way would be to apply the patch as is. Then
> someone can make it generic.

> So now it depends on Michael's decision :)

Yeah I'll merge it and then folks can do whatever they like.

cheers
