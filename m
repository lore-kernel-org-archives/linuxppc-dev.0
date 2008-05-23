Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D69C6DDFC6
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 May 2008 16:39:29 +1000 (EST)
Message-Id: <4B12DBAE-BB24-4114-BFEB-FF369E461622@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Bruce_Leonard@selinc.com
In-Reply-To: <OF2C9C3CB1.4A6FAC88-ON88257451.00760B81-88257451.00761D72@selinc.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: Question about "native" compiling
Date: Fri, 23 May 2008 01:39:22 -0500
References: <OF2C9C3CB1.4A6FAC88-ON88257451.00760B81-88257451.00761D72@selinc.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 22, 2008, at 4:30 PM, Bruce_Leonard@selinc.com wrote:

> Hi all,
>
> I apologize if the list finds this off topic, but I'm at a loss of  
> who to
> ask the question and thought this would be a good place to start.  Our
> target is an MPC8347E PowerQUICC II Pro, and we're using the latest  
> kernel
> (2.6.25).  We started this project by building on x86 and doing
> cross-compiling to the powerpc target.  As the project progressed  
> and we
> started adding applications we found that we couldn't cross-compile
> postgress among other things.  So we switched to native compilation  
> on the
> target.  Problem is, it's extreamly slow.  Now our idea is to get our
> hands on a PowerPC based Mac, load it up with Ubuntu and do native  
> builds
> on that.  The question is, which Mac to get?  The concern is this: a  
> G5 is
> 64-bit but the 8347E is 32-bit.  If we do our compiles on a G5 is it
> really a 'native' compile or is it a cross-compile and we're back in  
> the
> same boat as we were with the x86?  Should we use a G4 instead?
>
> Thanks for any advice or pointers to other places where I can find
> information.

Do you plan on running the same Ubuntu install (for ppc32) on the  
8347e?  If not you'll need to be careful to ensure libraries, etc are  
the same or compatible.

- k
