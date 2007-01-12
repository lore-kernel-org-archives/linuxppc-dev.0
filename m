Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 20E08DDE4A
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 23:18:29 +1100 (EST)
In-Reply-To: <20070112084612.GJ11226@localhost.localdomain>
References: <20070111122855.GF11226@localhost.localdomain>
	<37B2A6BB-4F36-4765-A1C2-A4F8D30D4503@kernel.crashing.org>
	<20070111152137.GG11226@localhost.localdomain>
	<17831.627.162751.166002@cargo.ozlabs.ibm.com>
	<20070112084612.GJ11226@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a66471d24eb1f36ad8a2a2feac95bb2d@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] add restart function for mpc52xx
Date: Fri, 12 Jan 2007 13:19:03 +0100
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Sylvain Munaut <tnt@246tNt.com>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On system with real open firmware it's surely the way to go to use it,
> but on systems without OF it's just painful. Not being able to 
> implement
> a restart function without changing the device tree shows that.

That's bullshit.  You use the watchdog timer to implement
system restart functionality; and you didn't describe the
watchdog hardware in the device tree.  You should have had
it in there already.


Segher
