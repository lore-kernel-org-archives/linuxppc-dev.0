Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 696D32BDB5
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Oct 2004 09:23:40 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guido Guenther <agx@sigxcpu.org>
In-Reply-To: <20041004151259.GC5637@bogon.ms20.nix>
References: <20041004112105.GA5637@bogon.ms20.nix>
	<1096897172.23141.87.camel@gaston>
	<20041004135108.GB5637@bogon.ms20.nix>
	<1096899251.15766.101.camel@gaston>
	<20041004151259.GC5637@bogon.ms20.nix>
Content-Type: text/plain
Message-Id: <1096931912.23141.107.camel@gaston>
Mime-Version: 1.0
Date: Tue, 05 Oct 2004 09:18:33 +1000
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [agx@sigxcpu.org: [PATCH]: swsusp on linux-2.6.9-rc3]
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2004-10-05 at 01:12, Guido Guenther wrote:
> On Tue, Oct 05, 2004 at 12:14:11AM +1000, Benjamin Herrenschmidt wrote:
> > A hack I wrote a while ago that allows to run the MacOS "ndrv" video
> > driver within a userland "shell" in linux. It works with old-style
> > 'ndrv's that ATI still uses but not with the newer nVidia 'fully native'
> > drivers and it can spy all IOs done by the driver

> Nice. Can you think of a way to monitor calls of MacOS X into the OF?

It has nothing to do with OF. We need to spy the IO accesses. Roughly
the same mecanism I use on linux but moved to kernel-land in OS X
would be possible but complicated: basically feeding the nvdia driver
with a non-mapped IO area and catching all faults, emulating the actual
accesses and logging them. But my knowledge of OS X low levels isn't
that good and I don't have time to work on that.

Ben.
