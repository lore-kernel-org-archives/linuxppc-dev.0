Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BD554DDD01
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Mar 2009 08:46:21 +1100 (EST)
Subject: Re: Fix for __div64_32 locks when using some 64 bit numbers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: davidastro <davidastro@hotmail.com>
In-Reply-To: <22627440.post@talk.nabble.com>
References: <22567864.post@talk.nabble.com>
	<1237330984.25062.164.camel@pasglop>  <22627440.post@talk.nabble.com>
Content-Type: text/plain
Date: Sun, 22 Mar 2009 08:46:13 +1100
Message-Id: <1237671973.25062.667.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2009-03-20 at 12:33 -0700, davidastro wrote:
> Hi Ben:
> 
> I was wondering if you have any change to look into and test the propose fix
> I suggested in my previous post.
> I'd like to know if the fix is correct.

Sorry, I haven't had a chance yet. I will asap.

Ben.

> Thanks for your attention,
> 
> 
> Benjamin Herrenschmidt wrote:
> > 
> > On Tue, 2009-03-17 at 14:15 -0700, davidastro wrote:
> >> I found a bug when using the function __div64_32 in assembly in a 32 bit
> >> ppc
> >> architecture unit.
> >> 
> >> I tried the numbers 55834565048000000 for the dividend and 4294967079 for
> >> the divisor. When passing these two numbers to the function  __div64_32,
> >> I
> >> had a software lock. I searched for possible patches online and in
> >> different
> >> forums but I could not find anything related to the assembly
> >> implementation
> >> to this function (I would have to apologize if somebody already found a
> >> fix
> >> :-) ).
> >> 
> >> Anyway, when analyzing the assembly code, I found out with gdb the
> >> problem.
> >> I am not an expert in ppc architecture but I read the documentation and I
> >> am
> >> pretty sure I solved the issue (I have been testing for couple of days
> >> using
> >> random 64 to 32 number combinations with good results).
> >> 
> >> Who or Where should I post the fix to be reviewed.
> > 
> > Here is fine :-)
> > 
> > Ben.
> > 
> > 
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> > 
> > 
> 
