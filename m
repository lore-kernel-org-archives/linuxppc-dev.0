Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rztcW5glDzDrLL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 21:51:23 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id g202so1749984pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 04:51:23 -0700 (PDT)
Date: Wed, 27 Jul 2016 21:51:15 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, "open list:LINUX FOR
 POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>, Michael
 Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Vaidyanathan S <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH] Make system_reset_pSeries relocatable
Message-ID: <20160727215115.166b1c72@roar.ozlabs.ibm.com>
In-Reply-To: <CAKTCnz=YD_mf_c45_fWzjgaaVg+tC98LAxAr4Wu8FWr7At8BRQ@mail.gmail.com>
References: <48aad8b6-a27f-44c5-2b0b-f276595e9c04@gmail.com>
 <1469613238.5978.144.camel@kernel.crashing.org>
 <CAKTCnz=YD_mf_c45_fWzjgaaVg+tC98LAxAr4Wu8FWr7At8BRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 27 Jul 2016 20:01:24 +1000
Balbir Singh <bsingharora@gmail.com> wrote:

> On Wed, Jul 27, 2016 at 7:53 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Wed, 2016-07-27 at 17:32 +1000, Balbir Singh wrote:  
> >> From: Balbir Singh <bsingharora@gmail.com>
> >>
> >> Currently the power management bits are broken w.r.t. relocation.
> >> There are direct branches from system_reset_pSeries to
> >> power7_wakeup_*.  
> >
> > Side track: we should really get rid of the _pSeries suffix for
> > these things :-)
> >  
> 
> I thought about it, but then thought it would need more auditing
> across places and hence held back. I'll be happy to send another patch
> to remove _pSeries from the exception-64s.S to begin with as a follow
> up

Ahh, my patches do that actually. Not as a primary concern, but
I removed almost all labels and naming from the exception-64s.h file,
and moved them into new head-64.h, so I changed the names a little
in the process.

It would be helpful to not touching this too much before we have some
more discussion of my reworking. I'm happy to rebase my stuff on top of
bugfixes though, of course.

Thanks,
Nick
