Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B621EDDE3B
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 19:06:23 +1100 (EST)
Subject: Re: [PATCH 2/3] powermac: proper time of day after resume
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
In-Reply-To: <1169710754.24087.36.camel@thor.sulgenrain.local>
References: <20061213123819.403286000@sipsolutions.net>
	<20061213123945.386891000@sipsolutions.net>
	<1169620444.18754.66.camel@localhost.localdomain>
	<20070124085420.GA19810@iram.es>
	<1169631177.18754.82.camel@localhost.localdomain>
	<20070124103621.GA22579@iram.es>
	<2435847C-A9FC-4430-A122-416B9B347038@kernel.crashing.org>
	<1169675091.18754.84.camel@localhost.localdomain>
	<1169710754.24087.36.camel@thor.sulgenrain.local>
Content-Type: text/plain; charset=utf-8
Date: Thu, 25 Jan 2007 19:06:16 +1100
Message-Id: <1169712376.24996.87.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-01-25 at 08:39 +0100, Michel Dänzer wrote:
> On Thu, 2007-01-25 at 08:44 +1100, Benjamin Herrenschmidt wrote:
> > > > The best solution may require informing the user space ntp code of
> > > > such events. This requires very likely modifications to ntp itself
> > > > (I may be wrong, I've not looked at NTP code for 5 years or so).
> > > 
> > > Doesn't the kernel send signals to init on suspend/resume
> > > events, just like with power fail events?  You can hook on
> > > that.
> > 
> > I don't think it does... at least not on powerbooks.
> 
> It could be handled by scripts invoked from pbbuttonsd or pmud on wakeup
> though, couldn't it? I thought there used to be one for that
> in /etc/apm/, but I can't find it now...

Well, I'm not sure I've fully followed how these things changed over the
last couple of years but yes, there used to be one called by pmud and
possibly pbbuttonsd too in /etc/power/pwrctl but distro I think -also-
hook that top APM stuffs among others.

Ben.
