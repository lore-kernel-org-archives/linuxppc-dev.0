Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D4AA02BD6A
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Oct 2004 00:19:15 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guido Guenther <agx@sigxcpu.org>
In-Reply-To: <20041004135108.GB5637@bogon.ms20.nix>
References: <20041004112105.GA5637@bogon.ms20.nix>
	<1096897172.23141.87.camel@gaston>
	<20041004135108.GB5637@bogon.ms20.nix>
Content-Type: text/plain
Message-Id: <1096899251.15766.101.camel@gaston>
Mime-Version: 1.0
Date: Tue, 05 Oct 2004 00:14:11 +1000
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

On Mon, 2004-10-04 at 23:51, Guido Guenther wrote:
> On Mon, Oct 04, 2004 at 11:39:32PM +1000, Benjamin Herrenschmidt wrote:
> > I have more of that in a tree here that I need to rediff... paulus also
> > got real sleep working on his M10 based 15" albook by spying the MacOS
> > driver using that ndrver hack I wrote a while ago, hopefully, we'll get
> > that in shape & merged soon.

> Great! Let me know if I can help to get this merged. What exactly is the
> ndrver hack? Google didn't show up anything.

A hack I wrote a while ago that allows to run the MacOS "ndrv" video
driver within a userland "shell" in linux. It works with old-style
'ndrv's that ATI still uses but not with the newer nVidia 'fully native'
drivers and it can spy all IOs done by the driver

Ben.
