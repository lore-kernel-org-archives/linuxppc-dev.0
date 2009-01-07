Return-Path: <chandru@in.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [59.145.155.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp06.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5DE35474D5
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 01:37:47 +1100 (EST)
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28smtp06.in.ibm.com (8.13.1/8.13.1) with ESMTP id n07EbgFn008126
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jan 2009 20:07:42 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n07Ea4iq3346666
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jan 2009 20:06:04 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.13.1/8.13.3) with ESMTP id n07EbgSK006273
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jan 2009 01:37:42 +1100
From: Chandru <chandru@in.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: kernel panics with crashkernel=256M while booting
Date: Wed, 7 Jan 2009 20:07:44 +0530
References: <200812221614.17952.chandru@in.ibm.com>
	<1231293017.14860.48.camel@pasglop>
In-Reply-To: <1231293017.14860.48.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901072007.45098.chandru@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 07 January 2009 07:20:17 Benjamin Herrenschmidt wrote:
> On Mon, 2008-12-22 at 16:14 +0530, Chandru wrote:
> > On a ppc64 machine booting linux-2.6.28-rc9 with crashkernel=256M@32M
> > boot parameter caused the kernel to panic while booting.  Follwing is the
> > console message..
>
> This is a fix to generic code. Can you resubmit it to linux-mm and/or
> linux-kernel ? You can still CC linuxppc-dev but it should be handled by
> one of the core mm maintainers.
>
> Cheers,
> Ben.

Its been submitted to lkml too. You have also been added to the cc list of the 
thread.

Chandru
