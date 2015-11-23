Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 552321A02B0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:12:39 +1100 (AEDT)
Message-ID: <1448273552.3452.7.camel@ellerman.id.au>
Subject: Re: linuxppc patchwork queue
From: Michael Ellerman <mpe@ellerman.id.au>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 23 Nov 2015 21:12:32 +1100
In-Reply-To: <CAOJe8K2KSL4yvkZpuJ-ZWiY7L0q8+fgkOp0rKOzCUTgGhmy5Bw@mail.gmail.com>
References: <CAOJe8K3ny5gsUjEOGA5DqmyW5HyxN8_8d2PqkxAj_JpN-nz7Cw@mail.gmail.com>
 <1448237735.18775.3.camel@ellerman.id.au>
 <CAOJe8K2KSL4yvkZpuJ-ZWiY7L0q8+fgkOp0rKOzCUTgGhmy5Bw@mail.gmail.com>
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

On Mon, 2015-11-23 at 12:45 +0300, Denis Kirjanov wrote:
> On 11/23/15, Michael Ellerman <mpe@ellerman.id.au> wrote:
> > Hi Denis,
> > 
> > On Fri, 2015-11-20 at 17:48 +0300, Denis Kirjanov wrote:
> > > Hi guys,
> > > 
> > > As we all know we have a great tool to track the patch queue - patchwork.
> > > The sad thing is that it's maintained not good as it could be. The
> > > netdev patchwork is a great example of how it can be done and I bet
> > > everyone would love to see the ppc patch queue like that.
> > 
> > What exactly is wrong with it?
> 
> I just wanted to point out that we have some patches without any reply like
> https://patchwork.ozlabs.org/patch/518981/ or patches since 2010.

OK.

518981 was part of a big series adding that stuff to lots of drivers. I was
waiting to see if someone was picking up the whole series, or if I was expected
to. I'll put those in this merge window.

It's true we have some old stuff lying around. Some of them are things we still
mean to look at, but just haven't had time, and others are just old junk that
we never get around to. I generally work from the top of the list and never get
to the bottom :)

And most of those old patches are delegated to Benh & Scottwood anyway ;)

> > > So can we improve the current situation? I'd love to help in any way
> > > possible.
> > 
> > You could send fewer patches ;)
> 
> I could, but I want make it better :)

Yeah that was a bit sarcastic of me :)

The main thing you could do, and anyone could do (!), is just review some
patches. Even if you don't know the area of code that well, you can usually do
a basic review.

eg. Just the basic stuff:
 - Is the subject correctly formatted and makes sense.
 - Is the change log well written and describes the change well.
 - Does the patch do one logical change.
 - Are there any obviously bad coding style things.
 - Can you follow the basics of the change based on the change log and some
   reading of the code?

Another thing I seem to spend a lot of time on is asking people if their patch
should go to stable or not, and if so what versions. So everyone could help out
there.

cheers
