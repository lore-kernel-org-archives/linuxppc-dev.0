Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6175667A8D
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Jan 2005 10:02:51 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Colin Leroy <colin@colino.net>
In-Reply-To: <20050127195205.192c8c28@jack.colino.net>
References: <1106012932.4533.46.camel@gaston>
	<20050127195205.192c8c28@jack.colino.net>
Content-Type: text/plain
Date: Fri, 28 Jan 2005 10:01:14 +1100
Message-Id: <1106866874.6250.97.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] radeonfb: massive update of PM code
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2005-01-27 at 19:52 +0100, Colin Leroy wrote:
> On 18 Jan 2005 at 12h01, Benjamin Herrenschmidt wrote:
> 
> Hi Ben, 
> 
> > This patch is a quite massive update to radeonfb. It adds the ability
> > to reboot from scratch the various chip models used on the recent
> > powermac laptops, adds a bunch of new chips (including R420 support,
> > untested), plus various fixes here or there including LCD & flat panel
> > blanking, abuse of stack usage in radeonfb_set_par(), and finally,
> > adapts the PM code to the recent powermac changes.
> 
> I just upgraded to 2.6.10, applied the 6 other patches you sent and this
> one. This one makes some heavy video corruption on my iBook G4
> (PowerBook6,3). The patch applies with a 27 lines offset at most hunks,
> but does no rejects. 
> 
> I'm using xorg 6.7.0, and your test sleep patch #7 on 2.6.9 worked fine.
> 
> Tell me if I can be of any help...

Well, this is basically equivalent to sleep #7 patch, so I'm not sure
what's wrong...

Ben.
