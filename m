Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 591F0DDDF8
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Sep 2007 21:54:02 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8HBrwc6007171
	for <linuxppc-embedded@ozlabs.org>; Mon, 17 Sep 2007 07:53:58 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8HBrwuP296780
	for <linuxppc-embedded@ozlabs.org>; Mon, 17 Sep 2007 05:53:58 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8HBrwDk010337
	for <linuxppc-embedded@ozlabs.org>; Mon, 17 Sep 2007 05:53:58 -0600
Date: Mon, 17 Sep 2007 06:53:56 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: Device tree compiler
Message-ID: <20070917065356.430e472a@weaponx.rchland.ibm.com>
In-Reply-To: <200709171330.37642.laurentp@cse-semaphore.com>
References: <200709171330.37642.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 17 Sep 2007 13:30:37 +0200
Laurent Pinchart <laurentp@cse-semaphore.com> wrote:

> Hi everybody,
> 
> I'm trying to port a MPC8248-based board from ppc to powerpc.
> 
> While looking for example DTS files I found out that the Linux kernel sources 
> include a few of them in arch/powerpc/boot/dts. However, they don't compile 
> with the latest device-tree compiler available at 
> git://ozlabs.org/srv/projects/dtc/dtc.git.

Because that is ancient.  Use the one from:

git://www.jdl.com/software/dtc.git

Someone should really fix up the ozlabs page to stop pointing at
outdated versions of DTC.

josh
