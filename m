Return-Path: <ken@kenmoffat.uklinux.net>
Received: from ppgpenguin.kenmoffat.uklinux.net (unknown [82.1.142.232])
	by ozlabs.org (Postfix) with ESMTP id EEA4E2BD7B
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Sep 2004 20:16:34 +1000 (EST)
Date: Sun, 19 Sep 2004 11:16:22 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1095567908.6545.12.camel@gaston>
Message-ID: <Pine.LNX.4.58.0409191105090.31452@ppg_penguin.kenmoffat.uklinux.net>
References: <Pine.LNX.4.58.0409172249520.23520@ppg_penguin.kenmoffat.uklinux.net>
	<1095465662.3660.3.camel@gaston>
	<Pine.LNX.4.58.0409181032540.26433@ppg_penguin.kenmoffat.uklinux.net>
	<1095502166.6545.5.camel@gaston>
	<Pine.LNX.4.58.0409181233590.26883@ppg_penguin.kenmoffat.uklinux.net>
	<Pine.LNX.4.58.0409181735400.27956@ppg_penguin.kenmoffat.uklinux.net>
	<1095567908.6545.12.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
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

On Sun, 19 Sep 2004, Benjamin Herrenschmidt wrote:

> On Sun, 2004-09-19 at 02:37, Ken Moffat wrote:
> > On Sat, 18 Sep 2004, Ken Moffat wrote:
> >
> > > On Sat, 18 Sep 2004, Benjamin Herrenschmidt wrote:
> > >
> > > >
> > > > PVR is the Processor Version Register, indicates which CPU you have
> > > >
> > > > Ben.
> > > >
> > >  Thanks, I'd already found that on google.  First attempt to dump min=
e
> > > into a printk is building - don't hold your breathe ;-)
> > >
> >
> >  The PVR is 80010201 so it uses the "7455 others" code.
>
> Hrm... I invite you to read the gazillion errata for this chip rev :(
>

 Are they available online ?  Would I understand them ?

> You should also contact the AmigaOS folks, they might have configured
> something in the northbridge in a way that won't work when the M bit is
> set but there might be a workaround. I suppose their northbridge spec is
> kept behind closed door though, as it is common nowadays :(
>
> Ben.
>
>

 Actually, I think it's kept in a locked cupboard in a room labelled
"beware of the leopard", in a basement at the bottom of some broken
stairs.  FWIW, the option biting me is CPU_FTR_NEED_COHERENT - no real
surprises there.

 I'll have another go at trying to talk to them.  Thanks for your
responses.

Ken
--
 das eine Mal als Trag=F6die, das andere Mal als Farce
