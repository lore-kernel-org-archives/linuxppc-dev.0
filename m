Return-Path: <mohan@in.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CE5E8474C4
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2009 15:15:29 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n0D4FZcC009258
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 23:15:35 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n0D4FPPq185624
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 23:15:25 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n0D4FOrB004695
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 23:15:25 -0500
From: "M. Mohan Kumar" <mohan@in.ibm.com>
To: kexec@lists.infradead.org
Subject: Re: [PATCH 0/5 + 2] kexec updates
Date: Tue, 13 Jan 2009 09:45:20 +0530
References: <kexec-29-1.miltonm@bga.com> <20090112062359.GK7337@verge.net.au>
In-Reply-To: <20090112062359.GK7337@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200901130945.20596.mohan@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Simon Horman <horms@verge.net.au>,
	Paul Mackerras <paulus@samba.org>, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On Fri, Jan 02, 2009 at 02:42:38PM -0600, Milton Miller wrote:
> > Follwing this mail are 5 patches for kexec userspace and two for the
> > kernel.  The first fixes an array overflow and the second updates
> > userspace to the merged 2.6.28 kdump support.  The remaining are
> > cleanups and warning fixes, including one for the common code.
> > 
> > The two patchs for the kernel are independent.
> 
> Hi all,
> 
> sorry to be a bit slow in responding, this email landed just
> as I was leaving for a weeks holiday.
> 
> The kexec-tools patches seem reasonable to me and I'm happy to merge what I
> think are the latest versions - thanks Michael for your review.

Hi,

I tested both kernel and kexec-tools patches and kdump works fine. Tested on a 
POWER5 machine.

Regards,
Mohan.
