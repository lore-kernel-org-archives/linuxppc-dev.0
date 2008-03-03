Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E27C4DDE01
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 09:58:55 +1100 (EST)
Subject: RE: locking problem in sata_sil24?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rune Torgersen <runet@innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B0410A575@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B0410A524@ismail.innsys.innovsys.com>
	<1204583866.21545.31.camel@pasglop>
	<DCEAAC0833DD314AB0B58112AD99B93B0410A575@ismail.innsys.innovsys.com>
Content-Type: text/plain
Date: Tue, 04 Mar 2008 09:58:15 +1100
Message-Id: <1204585095.21545.37.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-03-03 at 16:44 -0600, Rune Torgersen wrote:
> Benjamin Herrenschmidt wrote:
> > On Mon, 2008-03-03 at 16:10 -0600, Rune Torgersen wrote:
> >> Hi I am trying to get PREEMPT_RT pach to wokr on my 2.6.24 kernel,
> 
> > What core is in the 8280 ? At this stage, I wouldn't rule out a bug in
> > the lockdep patches, I need to do more work on them.
> 
> Should be an 603e
> adn revision (from u-boot)
> CPU:   MPC8280 (HiP7 Rev 14, Mask 1.0 1K49M) at 447.897 MHz
> 
> 
> 
> I am currently compiling a LOCKDEP kernel for my x86 desktop, as it has
> the exact same SiliconImage controller on a card, so I'll see if it gets
> a similar detection.

In fact, I remember working on 64 bits lockdep, based on patches from
Johannes, but I didn't do 32 bits. I think somebody worked on it, but
now I can't find the patches...

Whoever did it can bounce them back to me ? I intend to do some more
work on this soon.

Cheers,
Ben.
