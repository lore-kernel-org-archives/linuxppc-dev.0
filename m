Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C903FDDE38
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 05:39:03 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8BJcjCF015022
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 15:38:45 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8BJcjjF059676
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 13:38:45 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8BJci3R015998
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 13:38:45 -0600
Date: Tue, 11 Sep 2007 14:38:40 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: [PATCH] [POWERPC] Fix interrupt routing and setup of ULI M1575
	on FSL boards
Message-ID: <20070911143840.553e267e@weaponx.rchland.ibm.com>
In-Reply-To: <65BEA2C0-2494-490E-B0EE-B51C96B64075@freescale.com>
References: <Pine.LNX.4.64.0708170003210.21006@blarg.am.freescale.net>
	<20070911172000.GC10743@lixom.net>
	<9C9F1918-1B55-4426-8138-842B9AAA5BD5@kernel.crashing.org>
	<20070911182234.GA12802@lixom.net>
	<424B650B-C272-45FC-BBC6-F090A9474082@kernel.crashing.org>
	<24F46474-1425-4C8B-A400-4D18D28932F2@freescale.com>
	<6EF5E5F8-703B-4C49-B458-92CD0CDF89A0@kernel.crashing.org>
	<65BEA2C0-2494-490E-B0EE-B51C96B64075@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 11 Sep 2007 14:22:21 -0500
Becky Bruce <becky.bruce@freescale.com> wrote:

> > maybe we should just have a platforms/fsl for all boards from  
> > freescale.  Not having things broken up by which processor family  
> > they are for.
> 
> What do you envision as being under there?  Subdirs?  How's it  
> organized? In some ways that might make sense, but I think we'd need  
> to sit down and think it through with all the twisted combinations  
> our hardware people come up with.  The fact is that there's really no  
> clean way to deal with all the wackiness.  So we just pick something  
> that fits OK and go with it.

Just butting in here, but I'd rather not see a platforms/fsl.  Just
stick the stuff in sysdev.  Companies get renamed, people use cores
from one company in their own products for another company, blah blah
blah.

Not that my opinion counts for much :)

josh
