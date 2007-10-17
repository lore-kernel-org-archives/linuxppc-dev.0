Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 130AADDEE0
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 06:12:52 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9HKCoUM007837
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 16:12:50 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9HKCnsd449414
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 14:12:49 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9HKCcx7022656
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 14:12:49 -0600
Date: Wed, 17 Oct 2007 15:12:30 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: Merge dtc
Message-ID: <20071017151230.01ccd2f8@weaponx.rchland.ibm.com>
In-Reply-To: <47166988.3010606@freescale.com>
References: <20071016050217.GA9052@localhost.localdomain>
	<B17BEF48-34FC-44E0-AC23-1DB7522EB198@kernel.crashing.org>
	<18196.20112.728499.256646@cargo.ozlabs.ibm.com>
	<5E3B6FCC-5930-4C76-AB4B-86B35551B9E0@kernel.crashing.org>
	<47166988.3010606@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul, Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 17 Oct 2007 14:59:04 -0500
Timur Tabi <timur@freescale.com> wrote:

> Kumar Gala wrote:
> 
> > Just out of interest who's complaining?  We don't include mkimage for  
> > u-boot related builds and I haven't seen any gripes related to that.
> 
> I think we should include mkimage *and* dtc.  But then, I'm not sure how much 
> weight my opinion has. :-)

Either way, if we're going to include DTC we need to do it soon.
mkimage I'm less worried about because it should be a much smaller
patch.

josh
