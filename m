Return-Path: <agx@sigxcpu.org>
Received: from honk1.physik.uni-konstanz.de (honk1.physik.uni-konstanz.de
	[134.34.140.224])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 55FFA2BDB8
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Oct 2004 17:08:48 +1000 (EST)
Date: Tue, 5 Oct 2004 08:58:28 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20041005065828.GB8169@bogon.ms20.nix>
References: <20041004112105.GA5637@bogon.ms20.nix>
	<1096897172.23141.87.camel@gaston>
	<20041004135108.GB5637@bogon.ms20.nix>
	<1096899251.15766.101.camel@gaston>
	<20041004151259.GC5637@bogon.ms20.nix>
	<1096931912.23141.107.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1096931912.23141.107.camel@gaston>
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

On Tue, Oct 05, 2004 at 09:18:33AM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2004-10-05 at 01:12, Guido Guenther wrote:
> > On Tue, Oct 05, 2004 at 12:14:11AM +1000, Benjamin Herrenschmidt wrote:
> > > A hack I wrote a while ago that allows to run the MacOS "ndrv" video
> > > driver within a userland "shell" in linux. It works with old-style
> > > 'ndrv's that ATI still uses but not with the newer nVidia 'fully native'
> > > drivers and it can spy all IOs done by the driver
> 
> > Nice. Can you think of a way to monitor calls of MacOS X into the OF?
> 
> It has nothing to do with OF. We need to spy the IO accesses. Roughly
Well at least the nv driver uses the cards OF code to reiinitialize it
after resume.
 -- Guido
