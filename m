Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B764467B55
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 17:37:17 +1000 (EST)
Subject: Re: [PATCH] enable RTAS /proc for PowerPC/CHRP platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olaf@aepfle.de>
In-Reply-To: <20061020071408.GA4325@aepfle.de>
References: <1161152109.7906.6.camel@localhost.localdomain>
	<20061018073851.GA13083@aepfle.de>
	<1161211083.10524.13.camel@localhost.localdomain>
	<20061019070318.GA24642@aepfle.de>
	<1161300942.10524.64.camel@localhost.localdomain>
	<20061020054434.GC3277@aepfle.de>
	<1161323797.10524.150.camel@localhost.localdomain>
	<20061020062431.GB14390@powerlinux.fr>
	<20061020064456.GA3946@aepfle.de>
	<1161328314.10524.168.camel@localhost.localdomain>
	<20061020071408.GA4325@aepfle.de>
Content-Type: text/plain
Date: Fri, 20 Oct 2006 17:36:48 +1000
Message-Id: <1161329808.10524.185.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: akpm@osdl.org, Sven Luther <sl@bplan-gmbh.de>, tilmann@bitterberg.de,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-10-20 at 09:14 +0200, Olaf Hering wrote:
> On Fri, Oct 20, Benjamin Herrenschmidt wrote:
> 
> > > /proc/device-tree/{model,device_type,compatible} is enough to map
> > > everything reliable in the installer. Dont pollute /proc/cpuinfo
> > > further. There has already enough stuff that doesnt belong there, like
> > > pmac-generation, 'pmac flags', 'detected as', motherboard and machine.
> > > Oh, and bogomips...
> > 
> > Some powermac detection bits for older models are not actually available
> > via the device-tree :)
> 
> What is missing?

Well, PowerBook 2400 vs. 3400 typically. There is more that we don't
even implement in the kernel yet but maybe one day ... :)

Ben.
