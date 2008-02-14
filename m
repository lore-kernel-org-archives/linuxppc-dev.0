Return-Path: <mj+f-140208+linuxppc-dev=ozlabs.org@ucw.cz>
Received: from nikam.ms.mff.cuni.cz (nikam-dmz.ms.mff.cuni.cz [195.113.20.16])
	by ozlabs.org (Postfix) with ESMTP id 6A758DDFAF
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 08:45:17 +1100 (EST)
Date: Thu, 14 Feb 2008 22:45:14 +0100
From: Martin Mares <mj@ucw.cz>
To: David Miller <davem@davemloft.net>
Subject: Re: /proc/bus/pci and domains
Message-ID: <mj+md-20080214.214339.22251.nikam@ucw.cz>
References: <mj+md-20080213.154522.9237.albireo@ucw.cz>
	<20080214044323.GB1176@kroah.com>
	<mj+md-20080214.093558.3352.nikam@ucw.cz>
	<20080214.134305.237408044.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080214.134305.237408044.davem@davemloft.net>
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

Hi!

> > Would it be acceptable for the PPC folks to modify the code to add
> > domain numbers to the device numbers in /proc/bus/pci/devices in the
> > same format as the bus directories already have?
> 
> Be careful, things like the X server parse that file, and X's
> parser does not expect domain numbers there so you will break
> things :-(

Yes, but neither does it expect domain numbers in the directory names,
I guess :-)

But thanks for the tip, I will check X before I post the patch.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
A student who changes the course of history is probably taking an exam.
