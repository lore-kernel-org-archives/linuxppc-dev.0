Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 0FA31DDEBB
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 08:42:35 +1100 (EST)
Date: Thu, 14 Feb 2008 13:43:05 -0800 (PST)
Message-Id: <20080214.134305.237408044.davem@davemloft.net>
To: mj@ucw.cz
Subject: Re: /proc/bus/pci and domains
From: David Miller <davem@davemloft.net>
In-Reply-To: <mj+md-20080214.093558.3352.nikam@ucw.cz>
References: <mj+md-20080213.154522.9237.albireo@ucw.cz>
	<20080214044323.GB1176@kroah.com>
	<mj+md-20080214.093558.3352.nikam@ucw.cz>
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
Date: Thu, 14 Feb 2008 10:40:22 +0100

> Would it be acceptable for the PPC folks to modify the code to add
> domain numbers to the device numbers in /proc/bus/pci/devices in the
> same format as the bus directories already have?

Be careful, things like the X server parse that file, and X's
parser does not expect domain numbers there so you will break
things :-(
