Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 947EBDDEA2
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 21:59:15 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9JBx9lL018196
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 07:59:09 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9JBx9nI428314
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 05:59:09 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9JBx8Xa008120
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 05:59:08 -0600
Date: Fri, 19 Oct 2007 06:59:07 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] powerpc: Add -mno-spe for ARCH=powerpc builds
Message-ID: <20071019065907.42ea5355@weaponx.rchland.ibm.com>
In-Reply-To: <12EA14AC-6A3E-4322-9083-0C18996EC227@kernel.crashing.org>
References: <Pine.LNX.4.64.0710181655270.28684@blarg.am.freescale.net>
	<18199.59909.763111.810973@cargo.ozlabs.ibm.com>
	<12EA14AC-6A3E-4322-9083-0C18996EC227@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 18 Oct 2007 22:20:49 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Oct 18, 2007, at 6:19 PM, Paul Mackerras wrote:
> 
> > Kumar Gala writes:
> >
> >> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> >
> > Your commit message doesn't give any reason why you are doing this, or
> > any explanation of what goes wrong without it.  In fact, the commit
> > message is completely empty. :)  Please resubmit with a decent commit
> > message.
> 
> I will, just as an FYI I based this on your commit for -mno-altivec  
> (which has no rationale for the commit) :)

Do as he says, not as he does!  ;)

josh
