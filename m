Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6528CDE10E
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 09:35:44 +1100 (EST)
Subject: Re: [PATCH 2/3] powermac: proper time of day after resume
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <A030796C-8E88-4F26-A18A-AFA31010B510@kernel.crashing.org>
References: <20061213123819.403286000@sipsolutions.net>
	<20061213123945.386891000@sipsolutions.net>
	<1169620444.18754.66.camel@localhost.localdomain>
	<20070124085420.GA19810@iram.es>
	<1169631177.18754.82.camel@localhost.localdomain>
	<20070124103621.GA22579@iram.es>
	<2435847C-A9FC-4430-A122-416B9B347038@kernel.crashing.org>
	<1169675091.18754.84.camel@localhost.localdomain>
	<A030796C-8E88-4F26-A18A-AFA31010B510@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 25 Jan 2007 09:35:38 +1100
Message-Id: <1169678138.24996.5.camel@localhost.localdomain>
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

On Wed, 2007-01-24 at 23:24 +0100, Segher Boessenkool wrote:
> >>> The best solution may require informing the user space ntp code of
> >>> such events. This requires very likely modifications to ntp itself
> >>> (I may be wrong, I've not looked at NTP code for 5 years or so).
> >>
> >> Doesn't the kernel send signals to init on suspend/resume
> >> events, just like with power fail events?  You can hook on
> >> that.
> >
> > I don't think it does... at least not on powerbooks.
> 
> <Cpt. Picard voice>  Make it so.
> 
> :-)

Do you know of any timer that is still running while the box is asleep ?
I doubt KL timer is and MPIC timers are long gone on Apple HW ...

Ben.
