Return-Path: <pc@us.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 05BC467C47
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 17:12:28 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kB76COpO001842
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Dec 2006 01:12:24 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kB76COqS286710
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Dec 2006 01:12:24 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kB76CORX022971
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Dec 2006 01:12:24 -0500
Message-ID: <4577B0C7.80502@us.ibm.com>
Date: Thu, 07 Dec 2006 00:12:23 -0600
From: "Paul A. Clarke" <pc@us.ibm.com>
MIME-Version: 1.0
To: linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [Linux-fbdev-devel] [PATCH] Fbdev driver for IBM GXT4500P video
	cards
References: <17766.24132.505274.631108@cargo.ozlabs.ibm.com>
In-Reply-To: <17766.24132.505274.631108@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, adaplas@pol.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

Paul Mackerras wrote:
> This is an fbdev driver for the IBM GXT4500P display card found in
> some IBM System P (pSeries) machines.  These cards have hardware 2D
> and 3D capabilities, but the driver does not use them; it just exports
> a dumb framebuffer.

Any reason to believe this wouldn't work with a GXT6500P as well?  It's almost 
identical to the GXT4500P except for an added geometry engine.

I have one, but won't be near it again until mid-January.

(This is very cool, BTW!)
-- 
Regards,
Paul Clarke
