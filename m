Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Jimi Xenidis <jimix@pobox.com>
Subject: Re: [RFC] Add IBM Blue Gene/Q Platform
In-reply-to: <17203923-C5C4-4659-9F3C-786D20C5C62E@pobox.com>
References: <958841B4-9626-48A2-A28A-13EA3F1D52AE@pobox.com>
 <22146.1354858896@neuling.org>
 <17203923-C5C4-4659-9F3C-786D20C5C62E@pobox.com>
Date: Mon, 10 Dec 2012 11:12:50 +1100
Message-ID: <849.1355098370@neuling.org>
Cc: Andrew T Tauferner <ataufer@us.ibm.com>, Kumar Gala <kumar.gala@gmail.com>,
 Jay Bryant <jsbryant@us.ibm.com>, Todd Inglett <tinglett@us.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jimi Xenidis <jimix@pobox.com> wrote:

> 
> On Dec 6, 2012, at 11:41 PM, Michael Neuling <mikey@neuling.org> wrote:
> 
> >> commit f6e3c1f706cb6922349d639a74ff6c50acc8b9f8
> >> Author: Jimi Xenidis <jimix@pobox.com>
> >> Date:   Wed Dec 5 13:41:25 2012 -0500
> >> 
> >>    powerpc: Remove unecessary VSX symbols
> >> 
> >>    The symbol THREAD_VSR0 is defined to be the same as THREAD_FPR0.  Its
> >>    presence causes build issues with more complex configurations.
> >> 
> >>    Signed-off-by: Jimi Xenidis <jimix@pobox.com>
> >> 
> > 
> > Can you explain what these "complex configurations" are?
> 
> In an earlier email we discussed the possibility that there was the
> possibility/desire that a single binary could support either FPU, VSX
> and the new QPX.  However, if a CONFIG_VSX is not defined then
> THREAD_VSR0 does not get defined even though there might be some code
> that refers to it.  Since it is an alias for the same piece of storage
> I was hoping to solve my config issue and be simplify the code.

Yep, I remember the conversation.  I just want that explanation in the
commit log so others know *why* it was changed.

Mikey
