Return-Path: <horms@koto.vergenet.net>
Received: from koto.vergenet.net (koto.vergenet.net [210.128.90.7])
	by ozlabs.org (Postfix) with ESMTP id 7FB8A67A3D
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 12:55:46 +1000 (EST)
Date: Fri, 22 Sep 2006 10:21:10 +0900
From: Horms <horms@verge.net.au>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [Fastboot] [PATCH] kexec: remove memory reserve patching for
	powerpc device tree
Message-ID: <20060922012108.GL2561@verge.net.au>
References: <20060921011031.4BFEA67BCE@ozlabs.org>
	<1158803944.7062.9.camel@localhost.localdomain>
	<20060921025122.GA8573@verge.net.au>
	<1158810033.7062.23.camel@localhost.localdomain>
	<20060921135534.GA1542@in.ibm.com> <E1GQPNv-0003yi-H5@jdl.com>
	<20060921143253.GC1542@in.ibm.com>
	<20060922011153.39DD867B79@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060922011153.39DD867B79@ozlabs.org>
Cc: Jon Loeliger <jdl@jdl.com>, Fastboot mailing list <fastboot@lists.osdl.org>,
	linuxppc-dev@ozlabs.org, vgoyal@in.ibm.com
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

If someone wants to make a patch for kexec-tools I'm happy
to put it into kexec-tools-testing. Though I am a little dubious
about the possibilities of vendors taking any notice of it.

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/
