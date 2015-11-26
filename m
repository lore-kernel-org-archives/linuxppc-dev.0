Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1A6471A01D2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 17:49:17 +1100 (AEDT)
Message-ID: <1448520556.9839.15.camel@ellerman.id.au>
Subject: Re: linuxppc patchwork queue
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Axtens <dja@axtens.net>, Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 26 Nov 2015 17:49:16 +1100
In-Reply-To: <87r3jgv0pl.fsf@gamma.ozlabs.ibm.com>
References: <CAOJe8K3ny5gsUjEOGA5DqmyW5HyxN8_8d2PqkxAj_JpN-nz7Cw@mail.gmail.com>
 <1448237735.18775.3.camel@ellerman.id.au>
 <CAOJe8K2KSL4yvkZpuJ-ZWiY7L0q8+fgkOp0rKOzCUTgGhmy5Bw@mail.gmail.com>
 <1448273552.3452.7.camel@ellerman.id.au>
 <87r3jgv0pl.fsf@gamma.ozlabs.ibm.com>
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

On Tue, 2015-11-24 at 08:56 +1100, Daniel Axtens wrote:
> > The main thing you could do, and anyone could do (!), is just review some
> > patches. Even if you don't know the area of code that well, you can usually do
> > a basic review.
> > 
> > eg. Just the basic stuff:
> >  - Is the subject correctly formatted and makes sense.
> >  - Is the change log well written and describes the change well.
> >  - Does the patch do one logical change.
> >  - Are there any obviously bad coding style things.
> >  - Can you follow the basics of the change based on the change log and some
> >    reading of the code?
> 
> Michael gave me the same advice earlier this year, and I found it really
> helpful. As a result, I've been trying to do reviews.
> 
> I am by no means an expert, but here's what I found starting out:
> 
>  - Reviewing is a learned skill - you don't just start doing kernel dev
>    and get this magical sense of how to do reviews. This means it's OK
>    to start small, and that no-one expects your early reviews to be
>    amazing.

Yes!

>  - Reviewing gets much easier when you just jump in and start doing it!
> 
>  - A review doesn't have to focus on getting to a reviewed-by
>    tag. Asking good questions is equally if not more valuable.

Absolutely.

In fact I'm usually a bit sceptical of reviews that are only a Reviewed-by tag,
because that gives me no evidence that the reviewer actually reviewed it.

I'd much rather some questions and/or comments. Even if the patch is perfect,
there's almost always something that you can comment on. Even if it's just
observations like "this logic confused me until I realised X which makes it
work".

>  - It was easier to start with the 'little picture', or what Michael
>    calls the 'basic stuff'. Is it good C? Does the commit message make
>    sense? Is the spelling right? Does it do weird things without
>    explaining them? When you're starting it's OK to leave the 'big
>    picture'/architectural/design reviews to other people. I definitely
>    still do!

Yes exactly. Often just starting to review those things will give you enough
insight into the patch to start understanding it a bit more, or at the very
least you prompt the author into explaining what they're doing better, which is
almost always helpful.

cheers
