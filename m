Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E6598DDE08
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 01:13:39 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1KEDaqB029070
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 09:13:36 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1KEDaeG486260
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 07:13:36 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1KEDaX0024006
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 07:13:36 -0700
Subject: Re: [0/14] Ebony support, 2nd spin
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <1171980307.24204.66.camel@zod.rchland.ibm.com>
References: <20070220020837.GF17818@localhost.localdomain>
	<1171980307.24204.66.camel@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Tue, 20 Feb 2007 08:14:39 -0600
Message-Id: <1171980879.24204.67.camel@zod.rchland.ibm.com>
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

On Tue, 2007-02-20 at 08:05 -0600, Josh Boyer wrote:
> On Tue, 2007-02-20 at 13:08 +1100, David Gibson wrote:
> 
> > 	- The early serial hacks no longer use an entire 64-bit
> > 	  constant, so should work on non-64-bit aware assemblers
> 
> Yes, this compiles now with my toolchain.  However, I get no output
> after this:

Ignore this part.  It would have helped if I actually turned the config
option for the of_serial driver on.

josh
