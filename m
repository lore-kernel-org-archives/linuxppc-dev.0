Return-Path: <michaele@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 74D0F67B57
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 09:48:44 +1000 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp04.au.ibm.com (8.13.6/8.13.5) with ESMTP id k7ANtEqm151968
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 09:55:14 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.250.242])
	by sd0208e0.au.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7ANpvCC064962
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 09:52:02 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7ANmXKS005820
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 09:48:33 +1000
Subject: Re: latest git: compile error: arch/powerpc/kernel/built-in.o
From: Michael Ellerman <michaele@au1.ibm.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <20060810232102.GB3668@localhost>
References: <20060810181154.GA3668@localhost> <44DBA1C6.2020902@us.ibm.com>
	<20060810232102.GB3668@localhost>
Content-Type: text/plain
Date: Fri, 11 Aug 2006 09:48:32 +1000
Message-Id: <1155253712.7616.0.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-ppc <linuxppc-dev@ozlabs.org>
Reply-To: michaele@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-08-11 at 01:21 +0200, Wolfgang Pfeiffer wrote:
> On Thu, Aug 10, 2006 at 02:14:46PM -0700, Haren Myneni wrote:
> > Wolfgang Pfeiffer wrote:
> > 
> > A couple of Michael's patches are needed. I am able to build with your 
> > config file.
> > 
> > http://ozlabs.org/pipermail/linuxppc-dev/2006-July/024271.html
> > http://ozlabs.org/pipermail/linuxppc-dev/2006-July/024272.html
> 
> Yes. Works. Although I could take the patches on the pages above from the
> the corresponding messages that are still in my mail folder ... :)
> 
> Strange tho' - for me at least - that these patches from about 5 weeks (!)
> ago still don't seem to have made it into the current git tree ...

Hmm, yeah. My fault for not chasing them up :)

Paul, any objection to these two?

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
