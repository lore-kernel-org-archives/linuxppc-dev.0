Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0538D2BD6A
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Sep 2004 14:25:58 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ken Moffat <ken@kenmoffat.uklinux.net>
In-Reply-To: <Pine.LNX.4.58.0409181735400.27956@ppg_penguin.kenmoffat.uklinux.net>
References: <Pine.LNX.4.58.0409172249520.23520@ppg_penguin.kenmoffat.uklinux.net>
	<1095465662.3660.3.camel@gaston>
	<Pine.LNX.4.58.0409181032540.26433@ppg_penguin.kenmoffat.uklinux.net>
	<1095502166.6545.5.camel@gaston>
	<Pine.LNX.4.58.0409181233590.26883@ppg_penguin.kenmoffat.uklinux.net>
	<Pine.LNX.4.58.0409181735400.27956@ppg_penguin.kenmoffat.uklinux.net>
Content-Type: text/plain
Message-Id: <1095567908.6545.12.camel@gaston>
Mime-Version: 1.0
Date: Sun, 19 Sep 2004 14:25:08 +1000
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Problem with 745x errata in 2.6.8
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2004-09-19 at 02:37, Ken Moffat wrote:
> On Sat, 18 Sep 2004, Ken Moffat wrote:
> 
> > On Sat, 18 Sep 2004, Benjamin Herrenschmidt wrote:
> >
> > >
> > > PVR is the Processor Version Register, indicates which CPU you have
> > >
> > > Ben.
> > >
> >  Thanks, I'd already found that on google.  First attempt to dump mine
> > into a printk is building - don't hold your breathe ;-)
> >
> 
>  The PVR is 80010201 so it uses the "7455 others" code.

Hrm... I invite you to read the gazillion errata for this chip rev :(

You should also contact the AmigaOS folks, they might have configured
something in the northbridge in a way that won't work when the M bit is
set but there might be a workaround. I suppose their northbridge spec is
kept behind closed door though, as it is common nowadays :(

Ben.

-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
