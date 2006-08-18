Return-Path: <michaele@au1.ibm.com>
Received: from ausmtp06.au.ibm.com (ausmtp06.au.ibm.com [202.81.18.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 04916679E1
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 10:01:50 +1000 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp06.au.ibm.com (8.13.6/8.13.6) with ESMTP id k7I03CwL9195566
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 10:03:12 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.250.237])
	by sd0208e0.au.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7I057lo154714
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 10:05:07 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7I01hOp001936
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 10:01:43 +1000
Subject: Re: latest git: compile error: arch/powerpc/kernel/built-in.o
From: Michael Ellerman <michaele@au1.ibm.com>
To: Wolfgang Pfeiffer <roto@gmx.net>
In-Reply-To: <20060817120653.GA3440@localhost>
References: <20060810181154.GA3668@localhost> <44DBA1C6.2020902@us.ibm.com>
	<20060810232102.GB3668@localhost>
	<17636.4022.216093.611990@cargo.ozlabs.ibm.com>
	<20060817120653.GA3440@localhost>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 10:01:42 +1000
Message-Id: <1155859302.20832.0.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-ppc <linuxppc-dev@ozlabs.org>,
	Michael Ellerman <ellerman@au1.ibm.com>, Paul Mackerras <paulus@samba.org>
Reply-To: michaele@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-08-17 at 14:06 +0200, Wolfgang Pfeiffer wrote:
> On Thu, Aug 17, 2006 at 04:41:58PM +1000, Paul Mackerras wrote:
> > Wolfgang Pfeiffer writes:
> > 
> > > Strange tho' - for me at least - that these patches from about 5 weeks (!)
> > > ago still don't seem to have made it into the current git tree ...
> > 
> > 5 weeks ago was a particularly bad time for patches trying to get into
> > the git tree, since I was on vacation and then travelling to OLS. :)
> 
>     [ ... ]
> 
> Michael, Paul, and everyone else being involved:
> 
> My apologies for my perhaps too strong wording when I was complaining
> about the delay ... I didn't mean the words as ugly as they actually
> might read ...

No worries, thanks for catching the error and reporting it.

cheers

-- 
Michael Ellerman
IBM OzLabs

email: michaele@au.ibm.com
stime: ellerman@au1.ibm.com
notes: Michael Ellerman/Australia/IBM
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person
