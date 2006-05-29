Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 45F6B679FC
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 12:28:54 +1000 (EST)
Subject: Re: [Done] Re: snd-aoa: Sound gone after snd-aoa updates, on PB5,8
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfgang Pfeiffer <roto@gmx.net>
In-Reply-To: <20060529021756.GB3107@localhost>
References: <20060529020027.GA3107@localhost> <20060529021756.GB3107@localhost>
Content-Type: text/plain
Date: Mon, 29 May 2006 12:28:45 +1000
Message-Id: <1148869725.3918.12.camel@localhost.localdomain>
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

On Mon, 2006-05-29 at 04:17 +0200, Wolfgang Pfeiffer wrote:
> On Mon, May 29, 2006 at 04:00:27AM +0200, Wolfgang Pfeiffer wrote:
> > 
> > Hi
> > 
> > After some updates from http://johannes.sipsolutions.net/snd-aoa.git/
> > in the last few hours/minutes sound's gone here. Without changing
> > sound settings intentionally here. 
> > 
> > 
> 
> On Debian/unstable:
> After downgrading libasound2 from 1.0.11-6 to 1.0.11-3 I have sound
> again: 1.0.11-6 was, IINM, installed a few hours ago, which
>  - as it seems - broke sound here.

Have you tested that it wasn't just the renaming/re-ordering of some
controls ? Alsa is pretty bad with that, you may just have to go back to
alsamixer and reset some controls after updating the driver.

Ben.
