Return-Path: <ken@kenmoffat.uklinux.net>
Received: from ppgpenguin.kenmoffat.uklinux.net
	(spc2-brig1-3-0-cust232.asfd.broadband.ntl.com [82.1.142.232])
	by ozlabs.org (Postfix) with ESMTP id 5BD6F2BD7B
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Sep 2004 21:36:09 +1000 (EST)
Date: Sat, 18 Sep 2004 12:36:07 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1095502166.6545.5.camel@gaston>
Message-ID: <Pine.LNX.4.58.0409181233590.26883@ppg_penguin.kenmoffat.uklinux.net>
References: <Pine.LNX.4.58.0409172249520.23520@ppg_penguin.kenmoffat.uklinux.net>
	<1095465662.3660.3.camel@gaston>
	<Pine.LNX.4.58.0409181032540.26433@ppg_penguin.kenmoffat.uklinux.net>
	<1095502166.6545.5.camel@gaston>
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

On Sat, 18 Sep 2004, Benjamin Herrenschmidt wrote:

>
> > this usage of PVR was, so at the moment I haven't got a clue about what
> > it contains or how to read it, but I guess that's where the values in
> > the cpu_sec struct come from so I'll start looking.  Your comment on th=
e
> > northbridge sounds depressingly likely.
>
> PVR is the Processor Version Register, indicates which CPU you have
>
> Ben.
>
 Thanks, I'd already found that on google.  First attempt to dump mine
into a printk is building - don't hold your breathe ;-)

Ken
--=20
 das eine Mal als Trag=F6die, das andere Mal als Farce
