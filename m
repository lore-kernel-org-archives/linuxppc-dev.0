Return-Path: <mohan@in.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [59.145.155.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp01.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id ABE12B7B73
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Sep 2009 19:06:06 +1000 (EST)
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp01.in.ibm.com (8.14.3/8.13.1) with ESMTP id n8H95xOd025432
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Sep 2009 14:35:59 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8H95xCA2527384
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Sep 2009 14:35:59 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n8H95x3U006486
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Sep 2009 14:35:59 +0530
From: "M. Mohan Kumar" <mohan@in.ibm.com>
To: kexec@lists.infradead.org
Subject: Re: [RFC] [PATCH] Write to HVC terminal from purgatory code
Date: Thu, 17 Sep 2009 14:36:02 +0530
References: <20090907051407.GA2990@in.ibm.com>
	<20090908230911.GE4075@verge.net.au>
In-Reply-To: <20090908230911.GE4075@verge.net.au>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200909171436.02165.mohan@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Simon Horman <horms@verge.net.au>, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Mon, Sep 07, 2009 at 10:44:07AM +0530, M. Mohan Kumar wrote:
> > Write to HVC terminal from purgatory code
> >
> > Current x86/x86-64 kexec-tools print the message "I'm in purgatory" to
> > serial console/VGA while executing the purgatory code.  Implement this
> > feature for POWERPC pseries platform by using the H_PUT_TERM_CHAR
> > hypervisor call by printng to hvc console.
>
> This change seems reasonable to me, can any of the ppc people offer a
> review?
>

Sorry, I forgot to mention that this patch is tested on POWER5 (under 
hypervisor) and POWER4 Full System partition mode (under non-hypervisor)

Regards,
M. Mohan Kumar.
