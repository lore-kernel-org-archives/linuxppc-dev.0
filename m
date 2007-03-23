Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 07F46DDE3B
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Mar 2007 03:54:17 +1100 (EST)
Message-ID: <46040634.3040200@freescale.com>
Date: Fri, 23 Mar 2007 11:54:12 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 10/17] bootwrapper: Add dt_set_mac_addresses().
References: <20070317013159.GH3969@localhost.localdomain>
	<45FC8643.1080807@freescale.com>
	<20070318115656.GA12765@localhost.localdomain>
	<45FEA7B3.9090304@freescale.com>
	<20070320035957.GC21124@localhost.localdomain>
	<45FFE8FD.9020902@freescale.com>
	<20070321025447.GG27969@localhost.localdomain>
	<460148DC.3020600@freescale.com>
	<20070322000620.GC2295@localhost.localdomain>
	<1174576516.6595.542.camel@ld0161-tx32>
	<20070323032214.GC28006@localhost.localdomain>
	<4603E648.4030907@freescale.com>
	<fe12f78e018a5543b0e8f7fc636dc5c3@kernel.crashing.org>
	<4604035F.8070703@freescale.com>
	<10eb99e3d4037e36ba32d136f0e2bb52@kernel.crashing.org>
In-Reply-To: <10eb99e3d4037e36ba32d136f0e2bb52@kernel.crashing.org>
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

>> No, because that might break of_get_mac_address() which considers an 
>> all-zero MAC address to be invalid.
> 
> If you want to default a certain field, you shouldn't set it
> to ? ? ? ?, but to the default value you have in mind :-)

Fair enough, but then we can't use it for local-mac-address, which was the whole point 
behind this discussion!  So you can use ? for every property *except* local-mac-address. 
If it's going to be this complicated, I say forget the whole thing.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
