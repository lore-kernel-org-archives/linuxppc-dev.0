Return-Path: <vivek@in.ibm.com>
Received: from over.co.us.ibm.com (over.co.us.ibm.com [32.97.110.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 50AAB679F7
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 02:15:09 +1000 (EST)
Received: from e6.ny.us.ibm.com (e6.pok.ibm.com [9.56.232.146])
	by bldfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3RE0Ued003223
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 10:00:31 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3RE0O4j011931
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 10:00:24 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3RE0Ofm196934
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 10:00:24 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k3RE0Nes004490
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 10:00:24 -0400
Date: Thu, 27 Apr 2006 10:00:07 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [Fastboot] Documentation feedback request.
Message-ID: <20060427140007.GA7053@in.ibm.com>
References: <444FB2AF.3020802@us.ibm.com>
	<1146095071.29876.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1146095071.29876.23.camel@localhost.localdomain>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, fastboot@lists.osdl.org
Reply-To: vgoyal@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 27, 2006 at 09:44:31AM +1000, Michael Ellerman wrote:
> > Load the Dump-capture Kernel
> > ============================
> > 
> > After booting to the system kernel, load the dump-capture kernel using
> > the following command:
> > 
> >    kexec -p <dump-capture-kernel> \
> >    --initrd=<initrd-for-dump-capture-kernel> --args-linux \
> >    --append="root=<root-dev> init 1 irqpoll"
> 
> I've never tested irqpoll on powerpc, I'm not sure we want to recommend
> it, has someone tested it?
> 

We have tested it on x86 & x86_64 and it works fine. Not sure about powerpc.
Dave, Mohan and Mike have been doing some testing on powerpc. Guys any
inputs?

-vivek
