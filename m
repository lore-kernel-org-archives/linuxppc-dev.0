Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 661D72BDB8
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Oct 2004 17:31:52 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guido Guenther <agx@sigxcpu.org>
In-Reply-To: <20041005065828.GB8169@bogon.ms20.nix>
References: <20041004112105.GA5637@bogon.ms20.nix>
	<1096897172.23141.87.camel@gaston>
	<20041004135108.GB5637@bogon.ms20.nix>
	<1096899251.15766.101.camel@gaston>
	<20041004151259.GC5637@bogon.ms20.nix>
	<1096931912.23141.107.camel@gaston>
	<20041005065828.GB8169@bogon.ms20.nix>
Content-Type: text/plain
Message-Id: <1096961184.24537.38.camel@gaston>
Mime-Version: 1.0
Date: Tue, 05 Oct 2004 17:26:25 +1000
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

On Tue, 2004-10-05 at 16:58, Guido Guenther wrote:
> On Tue, Oct 05, 2004 at 09:18:33AM +1000, Benjamin Herrenschmidt wrote:
> > On Tue, 2004-10-05 at 01:12, Guido Guenther wrote:
> > > On Tue, Oct 05, 2004 at 12:14:11AM +1000, Benjamin Herrenschmidt wrote:
> > > > A hack I wrote a while ago that allows to run the MacOS "ndrv" video
> > > > driver within a userland "shell" in linux. It works with old-style
> > > > 'ndrv's that ATI still uses but not with the newer nVidia 'fully native'
> > > > drivers and it can spy all IOs done by the driver
> > 
> > > Nice. Can you think of a way to monitor calls of MacOS X into the OF?
> > 
> > It has nothing to do with OF. We need to spy the IO accesses. Roughly

> Well at least the nv driver uses the cards OF code to reiinitialize it
> after resume

They built a full OF interpreter in their driver ? We know how to
"locate" the card's OF, but it relies on a lot of stuffs, unless they
have this part of the code in a very self-contained limited portion of
their f-code which is easy to interpret ? It would be useful to have
more details from whoever told you that, knowing that they don't need to
tell us how to locate the card OF (I know there's some issues releasing
that information), just tell us what they do once they have it :)

Ben.
