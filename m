Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id ADC93DDFBE
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 02:09:51 +1100 (EST)
Message-ID: <46014AB2.2030701@freescale.com>
Date: Wed, 21 Mar 2007 10:09:38 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 10/17] bootwrapper: Add dt_set_mac_addresses().
References: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
	<20070316172853.GJ29784@ld0162-tx32.am.freescale.net>
	<20070317013159.GH3969@localhost.localdomain>
	<45FC8643.1080807@freescale.com>
	<20070318115656.GA12765@localhost.localdomain>
	<4efa309babf03924b549b5c84436e33b@kernel.crashing.org>
In-Reply-To: <4efa309babf03924b549b5c84436e33b@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:

> There *are* use cases for setting it statically in the DTS
> (bring up activities, ...) -- so please don't make it
> impossible to do so.

U-Boot has always updated the MAC address properties before booting 
Linux.  Therefore, you must be talking about a non-U-Boot scenerio.  If 
so, then I don't know what change I could make that would break this. 
If the [local-]mac-address property is in the DTS, then DTC will compile 
it and include it in the DTB.  That won't change.
