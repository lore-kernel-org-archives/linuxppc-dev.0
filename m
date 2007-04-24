Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0E7BFDDF53
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 09:54:46 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3NNsbdk010346
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2007 19:54:37 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3NNsbCG140980
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2007 17:54:37 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3NNsb6I029172
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2007 17:54:37 -0600
Date: Mon, 23 Apr 2007 19:01:54 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC/PATCH] Change 440GP platform to ppc440
Message-ID: <20070424000153.GD23995@crusty.rchland.ibm.com>
References: <Pine.LNX.4.64.0704191615040.25069@localhost.localdomain>
	<17961.22721.462194.785356@cargo.ozlabs.ibm.com>
	<CE31BB28-E702-4425-A266-9D5D143A53DC@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CE31BB28-E702-4425-A266-9D5D143A53DC@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 23, 2007 at 04:58:57PM -0500, Kumar Gala wrote:
> 
> On Apr 20, 2007, at 7:20 PM, Paul Mackerras wrote:
> 
> > Kumar Gala writes:
> >
> >> I don't see any reason the 440GP should its own platform.  Posting  
> >> this to
> >> see if anyone thinks otherwise.
> >
> > I recall dimly that there was some user-visible difference between the
> > 440GP and the other 440 processors, and that's why we made the
> > platform string different.  I don't recall what the difference was.
> 
> The 440GP seems to be a book-e userspace w/o FP.  Not sure how it  
> differs from other 440's.  It seems like the 440EP are the only ones  
> with FPUs.

Right.  I don't recall ever distinguishing 440GP from any other 440 chip
without an FPU.

josh
