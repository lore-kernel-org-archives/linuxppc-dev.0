Return-Path: <mj+f-140208+linuxppc-dev=ozlabs.org@ucw.cz>
Received: from nikam.ms.mff.cuni.cz (nikam-dmz.ms.mff.cuni.cz [195.113.20.16])
	by ozlabs.org (Postfix) with ESMTP id 14B37DE006
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 08:46:57 +1100 (EST)
Date: Thu, 14 Feb 2008 22:46:56 +0100
From: Martin Mares <mj@ucw.cz>
To: Matthew Wilcox <matthew@wil.cx>
Subject: Re: /proc/bus/pci and domains
Message-ID: <mj+md-20080214.214556.22909.nikam@ucw.cz>
References: <mj+md-20080213.154522.9237.albireo@ucw.cz>
	<20080214044323.GB1176@kroah.com>
	<mj+md-20080214.093558.3352.nikam@ucw.cz>
	<20080214.134305.237408044.davem@davemloft.net>
	<20080214214506.GB7657@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080214214506.GB7657@parisc-linux.org>
Cc: greg@kroah.com, linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org,
	linux-pci@atrey.karlin.mff.cuni.cz, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi!

> > Be careful, things like the X server parse that file, and X's
> > parser does not expect domain numbers there so you will break
> > things :-(
> 
> It might be best if we only place domain 0 in that file.

Yes, that's another possilibity. However, in such cases we should probably
create the subdirectories only for domain 0 as well.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"Beware of bugs in the above code; I have only proved it correct, not tried it." -- D.E.K.
