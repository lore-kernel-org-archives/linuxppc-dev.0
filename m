Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x232.google.com (mail-pg0-x232.google.com
 [IPv6:2607:f8b0:400e:c05::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40LkGq2w3nzDqwP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2018 22:43:14 +1000 (AEST)
Received: by mail-pg0-x232.google.com with SMTP id d6so717508pgt.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2018 05:43:14 -0700 (PDT)
Date: Wed, 11 Apr 2018 22:43:00 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2] powerpc/config: powernv_defconfig updates
Message-ID: <20180411224300.4ce97dc7@roar.ozlabs.ibm.com>
In-Reply-To: <CAKTCnzm3ckm7Pujnbc-XMfqNQ0Td8cDyCgwCgGU-6_WL_u9X8w@mail.gmail.com>
References: <20180411091203.28141-1-npiggin@gmail.com>
 <CAKTCnzmsrU1WCW54ZuX=1oSGt2Pv3wSZ=NYR-692ZmzkowC0nw@mail.gmail.com>
 <20180411204209.6f7e1a05@roar.ozlabs.ibm.com>
 <CAKTCnzm3ckm7Pujnbc-XMfqNQ0Td8cDyCgwCgGU-6_WL_u9X8w@mail.gmail.com>
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

On Wed, 11 Apr 2018 22:24:06 +1000
Balbir Singh <bsingharora@gmail.com> wrote:

> On Wed, Apr 11, 2018 at 8:42 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
> > On Wed, 11 Apr 2018 20:04:45 +1000
> > Balbir Singh <bsingharora@gmail.com> wrote:
> >  
> >> On Wed, Apr 11, 2018 at 7:12 PM, Nicholas Piggin <npiggin@gmail.com> wrote:  
> >> > For consideration:
> >> >
> >> > * Add IPv6 support built in + additional modules - Because it's 2018 maan.
> >> > * Add DEFERRED_STRUCT_PAGE_INIT - Let's see what breaks.  
> >>
> >> We did not find any benefits with this on a P8 in terms of boot time
> >> with large memory. May be worth reinvestigating  
> >
> > Worth putting in the defconfig just for testing until then?  
> 
> Absolutely!
> 
> >  
> >>  
> >> > * Add PPC_MEMTRACE - Small powernv debugfs driver for getting hardware traces.
> >> > * Add MEMORY_FAILURE - Machine check exceptions can now drive memory failure.  
> >
> >          ^^^^
> > Okay for this one?  
> 
> Yep definitely!
> 
> >  
> >> > * Turn on FANOTIFY - This is the current filesystem notification feature.
> >> > * Turn on SCOM_DEBUGFS - Handy for hardware/firmware debugging, security risk?  
> >>
> >> Yep, should not be in defconfig, IMHO  
> >
> > Why not? Honest question, I hear some things about secure
> > boot when I ask about this option but I'm not quite sure why, or
> > what we are securing here.
> >
> > If the firmware does not want us to mess with scoms, it should
> > restrict the call, no?
> >  
> 
> Yes, firmware definitely should. Do we need inband debugging?

I think it's a matter of convenience when testing and debugging
things. OTOH I haven't used it a great deal myself. Others do
want it if we can just ensure firmware will do the right thing
if we're in some secure configuration.

Thanks,
Nick
