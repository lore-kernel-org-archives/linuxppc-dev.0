Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3981B2BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Oct 2004 17:02:59 +1000 (EST)
Date: Mon, 25 Oct 2004 00:02:56 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Gerhard Jaeger <g.jaeger@sysgo.com>
Message-ID: <20041025070256.GA29968@gate.ebshome.net>
References: <20041022085733.0c5289c8.Hiroshi_DOYU@montavista.co.jp>
	<20041022082955.GA27169@gate.ebshome.net>
	<20041025011654.GA3290@gate.ebshome.net>
	<200410250847.00907.g.jaeger@sysgo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200410250847.00907.g.jaeger@sysgo.com>
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

On Mon, Oct 25, 2004 at 08:47:00AM +0200, Gerhard Jaeger wrote:
> On Monday 25 October 2004 03:16, Eugene Surovegin wrote:

[snip]

> > For *adventurous*, this new EMAC driver is available as a patch against
> > 2.6.9 BK tree at http://kernel.ebshome.net/. Please, note, it's still
> > project in progress and it lacks support for all new 440GX features
> > (GigE, TAH, jumbo frames, EMAC2/EMAC3). This is NAPI version with
> > correct (I hope) error handling, chip access etc. On Ebony I was able
> > to route around 144Kpps. I plan to implement support for _some_ 440GX
> > new features soon (during next month, hopefully).
> 
> I will give it a try ASAP.
> 

I've just put Ethtool patch which adds EMAC specific reg dump at the 
same URL.

--
Eugene
