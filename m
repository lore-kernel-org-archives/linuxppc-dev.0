Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 23FE8DDE0E
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 08:13:45 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lA9LDgwh022786
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Nov 2007 16:13:42 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	lA9LDfFW124778
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Nov 2007 14:13:41 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lA9LDf4i021754
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Nov 2007 14:13:41 -0700
Subject: Re: Using PVR value after boot?
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
In-Reply-To: <1194642444.21340.16.camel@pasglop>
References: <a340dd0e0711091239mdf1b772l1d5a8208f7def4f5@mail.gmail.com>
	<1194642444.21340.16.camel@pasglop>
Content-Type: text/plain
Date: Fri, 09 Nov 2007 15:13:26 -0600
Message-Id: <1194642806.3207.2.camel@localhost.localdomain>
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

On Sat, 2007-11-10 at 08:07 +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2007-11-09 at 15:39 -0500, Mike Nuss wrote:
> > I'm writing a module for the Security/KASUMI function on the
> > PPC440EPx-S and PPC440GRx-S. This relies on checking the PVR value at
> > runtime, which is done early on in the boot process.  What would be
> > the correct way to check which CPU is present during module
> > initialization?
> 
> Checking the PVR can be done at any time, though a better option would
> be to put something in device-tree of course :-)

Absolutely.

josh
