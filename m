Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0201DDDECE
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 22:49:32 +1000 (EST)
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] powerpc: Add -mno-spe for ARCH=powerpc builds 
In-Reply-To: Your message of "Thu, 18 Oct 2007 22:20:49 CDT."
	<12EA14AC-6A3E-4322-9083-0C18996EC227@kernel.crashing.org>
References: <Pine.LNX.4.64.0710181655270.28684@blarg.am.freescale.net>
	<18199.59909.763111.810973@cargo.ozlabs.ibm.com>
	<12EA14AC-6A3E-4322-9083-0C18996EC227@kernel.crashing.org>
Date: Fri, 19 Oct 2007 07:49:24 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IirI4-0004Ch-3P@jdl.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Kumar Gala mumbled:
> 
> On Oct 18, 2007, at 6:19 PM, Paul Mackerras wrote:
> 
> > Your commit message doesn't give any reason why you are doing this, or
> > any explanation of what goes wrong without it.  In fact, the commit
> > message is completely empty. :)  Please resubmit with a decent commit
> > message.
> 
> I will, just as an FYI I based this on your commit for -mno-altivec  
> (which has no rationale for the commit) :)

Hmmm.  And also, let's not forget that the mail Subject: line
does contribute to the git log commit message as well.

Thanks,
jdl
