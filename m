Return-Path: <jengelh@inai.de>
Received: from ares07.inai.de (ares07.inai.de [IPv6:2a01:4f8:161:ffa::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E3B8D2C0079
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2013 01:44:20 +1100 (EST)
Date: Thu, 17 Jan 2013 15:38:24 +0100 (CET)
From: Jan Engelhardt <jengelh@inai.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: therm_pm72 units, interface
In-Reply-To: <1345066616.11751.2.camel@pasglop>
Message-ID: <alpine.LNX.2.01.1301142240140.30171@nerf07.vanv.qr>
References: <alpine.LNX.2.01.1208151941010.22695@frira.zrqbmnf.qr>
 <1345066616.11751.2.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Wednesday 2012-08-15 23:36, Benjamin Herrenschmidt wrote:

>BTW... On a somewhat related note ... if you happen to have a spare
>Xserve G5 PSU I'm interested :-)

I tried pulling it out, but the PSU stuck so hard in the ATX-like 
mainboard power socket that removing the PSU would have probably meant 
ripping apart the MB.

Anyhow, I did a PMU reset (there's a documented button on the MB),
and 'lo, it seems the auto-poweroff that plagued this machine are
gone - but I'll need a longer uptime than 2 hours to find out.


Meanwhile, I run Linux 3.7.1 and the software side changed somewhat.
windfarm_rm31 seems to no longer calm the fans down once loaded,
whereas therm_pm72 on Linux 3.0 did so.
