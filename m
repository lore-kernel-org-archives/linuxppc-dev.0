Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 486F2DDFE8
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 09:16:40 +1100 (EST)
Date: Thu, 14 Feb 2008 14:17:11 -0800 (PST)
Message-Id: <20080214.141711.222843930.davem@davemloft.net>
To: mj@ucw.cz
Subject: Re: /proc/bus/pci and domains
From: David Miller <davem@davemloft.net>
In-Reply-To: <mj+md-20080214.214339.22251.nikam@ucw.cz>
References: <mj+md-20080214.093558.3352.nikam@ucw.cz>
	<20080214.134305.237408044.davem@davemloft.net>
	<mj+md-20080214.214339.22251.nikam@ucw.cz>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
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

From: Martin Mares <mj@ucw.cz>
Date: Thu, 14 Feb 2008 22:45:14 +0100

> But thanks for the tip, I will check X before I post the patch.

X now uses sysfs when available, therefore I think it's
best not to try and muck with this deprecated interface
if possible.
