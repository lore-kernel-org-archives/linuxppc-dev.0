Return-Path: <alistair@popple.id.au>
Received: from ipmail06.adl2.internode.on.net (ipmail06.adl2.internode.on.net
 [150.101.137.129])
 by lists.ozlabs.org (Postfix) with ESMTP id 41myQz2cwxzDqww
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2018 18:07:39 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Reza Arbab <arbab@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/powernv: Add support for NPU2 relaxed-ordering
 mode
Date: Fri, 10 Aug 2018 18:07:36 +1000
Message-ID: <4713418.DQXWlYYjMb@new-mexico>
In-Reply-To: <87pnyq8zsj.fsf@concordia.ellerman.id.au>
References: <1533698243-25972-1-git-send-email-arbab@linux.ibm.com>
 <87pnyq8zsj.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday, 10 August 2018 5:07:56 PM AEST Michael Ellerman wrote:
> Reza Arbab <arbab@linux.ibm.com> writes:
> > From: Alistair Popple <alistair@popple.id.au>
> >
> > Some device drivers support out of order access to GPU memory. This does
> > not affect the CPU view of memory but it does affect the GPU view, so it
> > should only be enabled once the GPU driver has requested it. Add APIs
> > allowing a driver to do so.
> 
> Do we have any indication which drivers we are expecting to use this?

I believe there is an internal driver that required these but I'm not sure if
there were any plans to make these available upstream or not.

> I'd prefer not to merge a new API unless we at least have some idea
> what's going to use it.

Fair enough. Unfortunately I am not aware of users future plans for usage of
this API.

- Alistair

> cheers
> 
