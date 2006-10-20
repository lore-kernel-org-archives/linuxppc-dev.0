Return-Path: <olaf@ibook.aepfle.de>
Received: from natklopstock.rzone.de (natklopstock.rzone.de [81.169.145.174])
	by ozlabs.org (Postfix) with ESMTP id DCD8767BAC
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 17:14:20 +1000 (EST)
Date: Fri, 20 Oct 2006 09:14:08 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] enable RTAS /proc for PowerPC/CHRP platform
Message-ID: <20061020071408.GA4325@aepfle.de>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1161328314.10524.168.camel@localhost.localdomain>
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

On Fri, Oct 20, Benjamin Herrenschmidt wrote:

> > /proc/device-tree/{model,device_type,compatible} is enough to map
> > everything reliable in the installer. Dont pollute /proc/cpuinfo
> > further. There has already enough stuff that doesnt belong there, like
> > pmac-generation, 'pmac flags', 'detected as', motherboard and machine.
> > Oh, and bogomips...
> 
> Some powermac detection bits for older models are not actually available
> via the device-tree :)

What is missing?
