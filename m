Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 96C78DDDA0
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Feb 2009 05:44:14 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n1JIiBDQ026276
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 11:44:11 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n1JIiBF2006786
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 12:44:11 -0600 (CST)
Date: Thu, 19 Feb 2009 12:44:10 -0600
From: Scott Wood <scottwood@freescale.com>
To: Daniel Ng <daniel.ng1234@gmail.com>
Subject: Re: How to bring up fs_enet on 2.6.27?
Message-ID: <20090219184410.GB4180@ld0162-tx32.am.freescale.net>
References: <mailman.5.1233190802.9523.linuxppc-dev@ozlabs.org>
	<49810367.5000904@consentry.com>
	<547eba1b0902182247g66c8b83se0855ff048413c01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <547eba1b0902182247g66c8b83se0855ff048413c01@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Mike Ditto <mditto@consentry.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 19, 2009 at 05:47:22PM +1100, Daniel Ng wrote:
> Or, perhaps it is ok for the 'of_platform' bus to have no devices on
> it, and so I might be using the wrong bus?? Why would this be?
> 
> Or is it something else??
> 
> Either way, I still get the following boot error message:
> 
> IP-Config: Device `eth0' not found.
> 
> -and fs_enet_probe() is NEVER called.
> 

See this thread:
http://ozlabs.org/pipermail/linuxppc-dev/2009-February/068467.html

-Scott
