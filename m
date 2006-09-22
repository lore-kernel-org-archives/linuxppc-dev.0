Return-Path: <vgoyal@in.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 29B2F67B6E
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Sep 2006 00:23:58 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e32.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8MENsdh031988
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 10:23:54 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8MENrMG264002
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 08:23:53 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8MENqPH024104
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 08:23:53 -0600
Date: Fri, 22 Sep 2006 10:23:25 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [Fastboot] [PATCH] kexec: remove memory reserve patching for
	powerpc device tree
Message-ID: <20060922142325.GG18611@in.ibm.com>
References: <20060921011031.4BFEA67BCE@ozlabs.org>
	<1158803944.7062.9.camel@localhost.localdomain>
	<20060921025122.GA8573@verge.net.au>
	<1158810033.7062.23.camel@localhost.localdomain>
	<20060921135534.GA1542@in.ibm.com> <E1GQPNv-0003yi-H5@jdl.com>
	<20060921143253.GC1542@in.ibm.com>
	<20060922011153.39DD867B79@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060922011153.39DD867B79@ozlabs.org>
Cc: Jon Loeliger <jdl@jdl.com>, Fastboot mailing list <fastboot@lists.osdl.org>,
	linuxppc-dev@ozlabs.org, Horms <horms@verge.net.au>
Reply-To: vgoyal@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 22, 2006 at 10:41:51AM +0930, Michael Neuling wrote:
> In message <20060921143253.GC1542@in.ibm.com> you wrote:
> > On Thu, Sep 21, 2006 at 09:18:39AM -0500, Jon Loeliger wrote:
> > > So, like, the other day Vivek Goyal mumbled:
> > > > 
> > > > Now with distros adopting kexce-tools, I am in for maintaining the backwa
> rd
> > > > compatibility as far as possible. Putting a note in the code is good that
> > > > down the line, get rid of this code.
> > > 
> > > Perhaps scheduling it as an entry in 
> > > 
> > >     Documentation/feature-removal-schedule.txt
> > > 
> > > just so people (distros) can plan around it?
> > 
> > Perfect. In kexec-tools it can go in doc/feature-removal-schedule.txt.
> 
> It doesn't really need to go in the kernel source as the kernel has
> already changed and besides, we were adding a feature to the kernel, not
> removing one.  
> 
> At this stage, it's just a kexec tools feature removal.
> 

Well, what I meant is that a similar file can go in kexec-tools/doc/ dir.

-Vivek
