Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8DDC22BDB8
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Oct 2004 17:30:16 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guido Guenther <agx@sigxcpu.org>
In-Reply-To: <20041005065744.GA8169@bogon.ms20.nix>
References: <20041004112105.GA5637@bogon.ms20.nix>
	<1096897172.23141.87.camel@gaston>
	<20041004135108.GB5637@bogon.ms20.nix>
	<1096899251.15766.101.camel@gaston>
	<20041004151259.GC5637@bogon.ms20.nix>
	<A5A9FF28-163F-11D9-B39F-000A95A4DC02@kernel.crashing.org>
	<20041005065744.GA8169@bogon.ms20.nix>
Content-Type: text/plain
Message-Id: <1096961085.24537.35.camel@gaston>
Mime-Version: 1.0
Date: Tue, 05 Oct 2004 17:24:45 +1000
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

On Tue, 2004-10-05 at 16:57, Guido Guenther wrote:
> On Mon, Oct 04, 2004 at 02:57:40PM -0500, Segher Boessenkool wrote:
> > >Nice. Can you think of a way to monitor calls of MacOS X into the OF?
> > 
> > The video driver is not calling into OF -- OF is long
> > dead and gone by the time the video driver runs.

> I was told that MacOS X reexecutes the cards OF code to reinitialize it
> after resume. I'd be nice for linux to do the same.

Who told you that ? I don't know of any facility in OS X to do that...

Ben.
