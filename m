Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id CB242DDF39
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 06:39:49 +1100 (EST)
Message-ID: <46018A00.9080703@freescale.com>
Date: Wed, 21 Mar 2007 14:39:44 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 10/17] bootwrapper: Add dt_set_mac_addresses().
References: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
	<20070316172853.GJ29784@ld0162-tx32.am.freescale.net>
	<20070317013159.GH3969@localhost.localdomain>
	<45FC8643.1080807@freescale.com>
	<20070318115656.GA12765@localhost.localdomain>
	<45FEA7B3.9090304@freescale.com>
	<1b943ac2c00b7f1f5696d006b67e9877@kernel.crashing.org>
	<46014BF5.6060509@freescale.com>
	<995355b28eecaafe955a5628ee939340@kernel.crashing.org>
	<46018315.1030703@freescale.com>
	<c4aa5f9e5e15d2e9686f77384f6cb532@kernel.crashing.org>
In-Reply-To: <c4aa5f9e5e15d2e9686f77384f6cb532@kernel.crashing.org>
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

Segher Boessenkool wrote:

> No, I'm saying that you shouldn't use "mac-address" for
> something it isn't meant for.

If the property exists in the device tree, then it should be used, no?  Whether or not it 
exists is not for the driver to decide.

What I hope to do is remove all traces of mac-address from the device trees.  If it's not 
in the DTS, then U-Boot won't add it, bootwrapper won't add it, the kernel won't add it, 
and therefore it won't exist when the driver loads, so the driver won't use it.

> You aren't supposed to have a "mac-address" property for
> devices that weren't used during firmware execution / booting
> _at all_.

I can't tell if we agree or disagree.  Perhaps you should look at the code and tell me 
what needs to be changed?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
