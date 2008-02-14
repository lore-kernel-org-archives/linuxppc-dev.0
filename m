Return-Path: <mj+f-140208+linuxppc-dev=ozlabs.org@ucw.cz>
Received: from nikam.ms.mff.cuni.cz (nikam-dmz.ms.mff.cuni.cz [195.113.20.16])
	by ozlabs.org (Postfix) with ESMTP id 38C2FDDFCE
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 09:21:56 +1100 (EST)
Date: Thu, 14 Feb 2008 23:21:55 +0100
From: Martin Mares <mj@ucw.cz>
To: David Miller <davem@davemloft.net>
Subject: Re: /proc/bus/pci and domains
Message-ID: <mj+md-20080214.221808.725.nikam@ucw.cz>
References: <mj+md-20080214.093558.3352.nikam@ucw.cz>
	<20080214.134305.237408044.davem@davemloft.net>
	<mj+md-20080214.214339.22251.nikam@ucw.cz>
	<20080214.141711.222843930.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080214.141711.222843930.davem@davemloft.net>
Cc: greg@kroah.com, linux-pci@atrey.karlin.mff.cuni.cz, paulus@samba.org,
	anton@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> X now uses sysfs when available, therefore I think it's
> best not to try and muck with this deprecated interface
> if possible.

However, the interface is fatally broken on machines with domains
and the breakage is visible (e.g., run lspci when /sys is not mounted).

I originally intended to just disable the proc backend on the affected
architectures, but it turned out than even x86 can be affected.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"God doesn't play dice."   -- Albert Einstein
