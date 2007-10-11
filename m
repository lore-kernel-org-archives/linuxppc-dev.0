Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 29D11DE141
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 08:08:03 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9BM7x5m013348
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 18:07:59 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9BM7xap474628
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 16:07:59 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9BM7wIF005792
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 16:07:58 -0600
Subject: Re: powerpc commits for 2.6.24
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <1192106826.5534.114.camel@localhost.localdomain>
References: <18190.5965.836544.396721@cargo.ozlabs.ibm.com>
	<1192106826.5534.114.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 11 Oct 2007 17:07:41 -0500
Message-Id: <1192140461.3061.11.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-10-11 at 07:47 -0500, Josh Boyer wrote:
> On Thu, 2007-10-11 at 22:30 +1000, Paul Mackerras wrote:
> > Below is the list of commits that I plan to ask Linus to pull
> > tomorrow.  This is the last call for anything else or for objections
> > to any of these commits going in.  These commits are in powerpc.git on
> > the master and for-2.6.24 branches.
> 
> Hi Paul,
> 
> Could you pull from:
> 
> master.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git for-2.6.24
> 
> to pick up some Xilinx changes from Grant?  I'm also hoping to get
> Stefan's 405EX changes in soon.

I added Stefan's latest patch set to my tree as well.  They look good.

josh
