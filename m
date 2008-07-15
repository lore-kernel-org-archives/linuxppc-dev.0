Return-Path: <srinivasa@in.ibm.com>
Received: from e23smtp06.au.ibm.com (E23SMTP06.au.ibm.com [202.81.18.175])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 03311DDE19
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 19:22:14 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id m6F9Lbds001291
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 19:21:37 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6F9KxVF4722802
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 19:20:59 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6F9Kxcj028767
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 19:20:59 +1000
From: Srinivasa D S <srinivasa@in.ibm.com>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: [RFC] [PATCH] task_pt_regs for powerpc systems
Date: Tue, 15 Jul 2008 14:51:00 +0530
References: <200807071952.27427.srinivasa@in.ibm.com>
	<487B8B22.6050701@freescale.com> <jemykkpdu8.fsf@sykes.suse.de>
In-Reply-To: <jemykkpdu8.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807151451.00265.srinivasa@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 14 July 2008 11:06:47 pm Andreas Schwab wrote:
> Timur Tabi <timur@freescale.com> writes:
> > Srinivasa D S wrote:
> >> +#define task_pt_regs(tsk)	(tsk)->thread.regs
> >
> > Shouldn't this be:
> >
> > 	#define task_pt_regs(tsk)	((tsk)->thread.regs)
> >
> > just to be safe?
>
> Both -> and . have already highest precedence as postfix operators.
>

Thanks for the comments, For safer side I have used "()"  and sent the updated 
patch.

Thanks
 Srinivasa DS
