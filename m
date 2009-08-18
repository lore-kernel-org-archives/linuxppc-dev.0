Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D6A99B6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 06:56:37 +1000 (EST)
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 641E4DDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 06:56:36 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7IKsTkj006694
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Aug 2009 14:54:29 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7IKuQCi217540
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Aug 2009 14:56:26 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7IKuPBC021668
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Aug 2009 14:56:26 -0600
Date: Tue, 18 Aug 2009 16:56:22 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Becky Bruce <beckyb@kernel.crashing.org>
Subject: Re: [PATCH/RFC] powerpc/mm: Cleanup handling of execute permission
Message-ID: <20090818205621.GB2530@zod.rchland.ibm.com>
References: <1248766373.30993.50.camel@pasglop>
	<FBB5798A-EE85-4B18-8883-F6182B203996@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <FBB5798A-EE85-4B18-8883-F6182B203996@kernel.crashing.org>
Cc: Kumar Gala <galak@gate.crashing.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 14, 2009 at 05:39:42PM -0500, Becky Bruce wrote:
> Ben,
>
> This breaks the boot on 8572.  I don't know why yet (and I'm probably  
> not going to figure it out before I go home, because, frankly, it's late 
> on a Friday afternoon and I need a glass of wine or, perhaps, a beer).
>
> Kumar and I will poke into this more and let you know what we find out - 
> in the meantime, if you have any brilliant flashes, pony up!

I tested this on a 440EPx NFS rootfs boot too.  It doesn't cause init itself
to crap out with a SIGILL like Becky's board, but it does do weird things
and cause a SIGILL elsewhere during my boot.

Reverting this patch from your testing branch allows things to work just fine.

josh
