Return-Path: <g.jaeger@sysgo.com>
Received: from mailgate.sysgo.de (ns.sysgo.de [213.68.67.98])
	by ozlabs.org (Postfix) with ESMTP id 60FC32BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Oct 2004 17:14:13 +1000 (EST)
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: Eugene Surovegin <ebs@ebshome.net>
Date: Mon, 25 Oct 2004 08:47:00 +0200
References: <20041022085733.0c5289c8.Hiroshi_DOYU@montavista.co.jp>
	<20041022082955.GA27169@gate.ebshome.net>
	<20041025011654.GA3290@gate.ebshome.net>
In-Reply-To: <20041025011654.GA3290@gate.ebshome.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410250847.00907.g.jaeger@sysgo.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [BUG] IBM440GX works too slow under nfsroot
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Monday 25 October 2004 03:16, Eugene Surovegin wrote:
> On Fri, Oct 22, 2004 at 01:29:55AM -0700, Eugene Surovegin wrote:
> > FWIW, I haven't seen any problems when testing my new EMAC driver with
> > 100Mb hub, maybe it's only 10Mb related.
> >
> > Anyway, this is first time I'm hearing about half duplex problems,
> > Matt just mentioned them on IRC to me.
> >
> > I'll try to do some tests this weekend, although I have to admit half
> > duplex doesn't seem very important these days, nevertheless, if this
> > can be fixed, we better do this :).
>
> OK, I did some tests with 2.4.28-pre4, 2.6.9 & 2.6.9-emac (2.6.9 with
> my new EMAC driver). I used Ocotea rev.3 with 440GX rev.C (533MHz).
>
> I can confirm I see some problems in 10HDX mode - there is visible
> slow down during system boot up (NFS root). Just after logging into
> system, nfsstat shows around 350 retransmits.
>
> My 2.6.9-emac tree doesn't show this behavior, I see no visible
> slow-down and nfsstat shows 0 retransmits.
>
> I tried some quick hacks for 2.6.9 driver but was unable to find
> settings which could help (my new driver was almost re-written from
> scratch and I did a lot of things differently).

Hmmm, that's what we also found out, nothing really helped.

> For *adventurous*, this new EMAC driver is available as a patch against
> 2.6.9 BK tree at http://kernel.ebshome.net/. Please, note, it's still
> project in progress and it lacks support for all new 440GX features
> (GigE, TAH, jumbo frames, EMAC2/EMAC3). This is NAPI version with
> correct (I hope) error handling, chip access etc. On Ebony I was able
> to route around 144Kpps. I plan to implement support for _some_ 440GX
> new features soon (during next month, hopefully).

I will give it a try ASAP.

>
> If there is an interest, I can make a patch against current 2.4 BK
> tree, but this will take some time (I'm a little swamped right now).

of course there's some interest, at least by me ;) Would be great if you'll
find some time for that.

Thank you,
  Gerhard
