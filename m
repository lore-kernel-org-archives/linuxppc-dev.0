Return-Path: <cyrilbur@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v36gv2bK8zDqJh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2017 11:06:03 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id 194so9153926pgd.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 16:06:03 -0800 (PST)
Message-ID: <1484697905.2266.1.camel@gmail.com>
Subject: Re: [PATCH] powerpc: Use octal numbers for file permissions
From: Cyril Bur <cyrilbur@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Russell Currey
 <ruscur@russell.cc>,  linuxppc-dev@lists.ozlabs.org
Date: Wed, 18 Jan 2017 11:05:05 +1100
In-Reply-To: <87a8aqau99.fsf@concordia.ellerman.id.au>
References: <20170112035413.26544-1-ruscur@russell.cc>
 <1484293883.2406.1.camel@gmail.com>
 <87a8aqau99.fsf@concordia.ellerman.id.au>
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

On Tue, 2017-01-17 at 20:52 +1100, Michael Ellerman wrote:
> Cyril Bur <cyrilbur@gmail.com> writes:
> 
> > On Thu, 2017-01-12 at 14:54 +1100, Russell Currey wrote:
> > > Symbolic macros are unintuitive and hard to read, whereas octal constants
> > > are much easier to interpret.  Replace macros for the basic permission
> > > flags (user/group/other read/write/execute) with numeric constants
> > > instead, across the whole powerpc tree.
> > > 
> > > Introducing a significant number of changes across the tree for no runtime
> > > benefit isn't exactly desirable, but so long as these macros are still
> > > used in the tree people will keep sending patches that add them.  Not only
> > > are they hard to parse at a glance, there are multiple ways of coming to
> > > the same value (as you can see with 0444 and 0644 in this patch) which
> > > hurts readability.
> > > 
> > > Signed-off-by: Russell Currey <ruscur@russell.cc>
> > 
> > Reviewed-by: Cyril Bur <cyrilbur@gmail.com>
> 
> Did you really really review every single change?
> 

Yes. I just went through it again and still didn't find any mistakes.

> Because if you did then I don't have to, and that would be *great* :)
> 

My pleasure :)

Interestingly enough, reviewing this patch taught me to quickly parse
the symbolics, which, for me now makes this patch less important haha.
I'm still in favour! No matter how fast you get at the symolics the
octal is still faster, also there's only one way to write the octal
permissions!


> cheers
