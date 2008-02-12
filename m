Return-Path: <bzolnier@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id 0DCE9DDE3F
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 08:41:47 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so632288uge.0
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 13:41:45 -0800 (PST)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 00/18] ide: warm-plug support for IDE devices and other
	goodies
Date: Tue, 12 Feb 2008 22:54:39 +0100
References: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
	<1202460043.7079.157.camel@pasglop>
	<1202850247.7410.24.camel@pasglop>
In-Reply-To: <1202850247.7410.24.camel@pasglop>
MIME-Version: 1.0
Message-Id: <200802122254.39663.bzolnier@gmail.com>
Content-Type: text/plain;
  charset="utf-8"
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 12 February 2008, Benjamin Herrenschmidt wrote:
> 
> On Fri, 2008-02-08 at 19:40 +1100, Benjamin Herrenschmidt wrote:
> > On Fri, 2008-02-08 at 01:44 +0100, Bartlomiej Zolnierkiewicz wrote:
> > > - couple of fixes and preparatory patches
> > > 
> > > - rework of PowerMac media-bay support ([un]register IDE devices instead of
> > >   [un]registering IDE interface) [ it is the main reason for spamming PPC ML ]
> > 
> > Interesting... I was thinking about doing a full remove of the device at
> > a higher level instead but I suppose what you propose is easier.
> > 
> > I'll have a look & test next week hopefully.
> 
> Also, the above would have the advantage of not relying on drivers/ide
> infrastructure, and thus working with libata (once somebody has ported
> pmac ide to libata).

Neither of these things exist at the moment so lets stick to the existing
code which is scheduled for 2.6.26 and which finally allows removal of ppc
specific ide hacks from arch/{powerpc,ppc} (500 LOC gone, patches to be
posted this week), not to mention other nice changes in the future...

Thanks,
Bart
