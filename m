Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 93985DDFD5
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 02:56:07 +1100 (EST)
Message-ID: <4601558F.3080004@freescale.com>
Date: Wed, 21 Mar 2007 10:55:59 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Subject: Re: [PATCH 10/17] bootwrapper: Add dt_set_mac_addresses().
References: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>	<20070316172853.GJ29784@ld0162-tx32.am.freescale.net>	<20070317013159.GH3969@localhost.localdomain>	<45FC8643.1080807@freescale.com>	<20070318115656.GA12765@localhost.localdomain>	<45FEA7B3.9090304@freescale.com>	<20070320035957.GC21124@localhost.localdomain>	<45FFE8FD.9020902@freescale.com>	<20070321025447.GG27969@localhost.localdomain>
	<460148DC.3020600@freescale.com>
	<46014E6A.90002@smiths-aerospace.com>
In-Reply-To: <46014E6A.90002@smiths-aerospace.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jerry Van Baren wrote:

> FWIIW, I'm getting close to having a usable implementation of a new 
> u-boot command "fdt" that is a lot cleaner than the hack-ish automagical 
> bootm copying and updating (and uses libfdt - thanks, David!).  I just 
> sent an update this morning:
> <http://article.gmane.org/gmane.comp.boot-loaders.u-boot/27187>

I saw that.  Once it gets incorporated into WD's tree, I'll take a look at it and see what 
we can do with it.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
