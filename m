Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0B18A478AF
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 07:52:13 +1100 (EST)
Subject: Re: kernel panics with crashkernel=256M while booting
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chandru <chandru@in.ibm.com>
In-Reply-To: <200901072007.45098.chandru@in.ibm.com>
References: <200812221614.17952.chandru@in.ibm.com>
	<1231293017.14860.48.camel@pasglop>
	<200901072007.45098.chandru@in.ibm.com>
Content-Type: text/plain
Date: Thu, 08 Jan 2009 07:52:03 +1100
Message-Id: <1231361523.2142.21.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-01-07 at 20:07 +0530, Chandru wrote:
> On Wednesday 07 January 2009 07:20:17 Benjamin Herrenschmidt wrote:
> > On Mon, 2008-12-22 at 16:14 +0530, Chandru wrote:
> > > On a ppc64 machine booting linux-2.6.28-rc9 with crashkernel=256M@32M
> > > boot parameter caused the kernel to panic while booting.  Follwing is the
> > > console message..
> >
> > This is a fix to generic code. Can you resubmit it to linux-mm and/or
> > linux-kernel ? You can still CC linuxppc-dev but it should be handled by
> > one of the core mm maintainers.
> >
> > Cheers,
> > Ben.
> 
> Its been submitted to lkml too. You have also been added to the cc list of the 
> thread.

Right, I saw the subsequent messages. The initial one was stale in
patchwork.

Cheers,
Ben.
