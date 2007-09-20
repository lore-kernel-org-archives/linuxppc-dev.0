Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7F6B7DDEE0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Sep 2007 11:18:44 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8L1IL1o019447
	for <linuxppc-embedded@ozlabs.org>; Thu, 20 Sep 2007 21:18:21 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8L1ILCV476400
	for <linuxppc-embedded@ozlabs.org>; Thu, 20 Sep 2007 19:18:21 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8L1IKiT020969
	for <linuxppc-embedded@ozlabs.org>; Thu, 20 Sep 2007 19:18:21 -0600
Subject: Re: Printing device tree on running system
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910709200921u3ffd6a37pe0ef268a2a171973@mail.gmail.com>
References: <9e4733910709200855p5a1cdf18v1848a31c7935ca5e@mail.gmail.com>
	<20070920160804.GA15796@ld0162-tx32.am.freescale.net>
	<9e4733910709200921u3ffd6a37pe0ef268a2a171973@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 19 Sep 2007 23:57:36 -0500
Message-Id: <1190264256.15845.10.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2007-09-20 at 12:21 -0400, Jon Smirl wrote:
> On 9/20/07, Scott Wood <scottwood@freescale.com> wrote:
> > On Thu, Sep 20, 2007 at 11:55:10AM -0400, Jon Smirl wrote:
> > > Is there a command for printing the device tree on a running system? I
> > > want to see what changes the various device drivers made to the DTC I
> > > started with.
> >
> > It's exported in /proc/device-tree, if support is built into the kernel.
> 
> That worked, didn't know the option existed.
> 
> >
> > It might be interesting to make dtc support turning that into a dts...

dtc does support that.  Pass /proc/device-tree/ to dtc like this:

dtc -I fs -o device-tree.dts -O dts /proc/device-tree

josh
