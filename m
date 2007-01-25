Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id F40F0DDDF6
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 16:19:46 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 1/1] next updated version, fixed cleanup and some minors
Date: Thu, 25 Jan 2007 06:19:31 +0100
References: <20061218163846.337fed65@localhost>
	<20070125143056.47cbd5d2@localhost>
	<20070125143415.10f43bfa@localhost>
In-Reply-To: <20070125143415.10f43bfa@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701250619.31544.arnd@arndb.de>
Cc: Christian Krafft <krafft@de.ibm.com>,
	openipmi-developer@lists.sourceforge.net, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 25 January 2007 04:34, Christian Krafft wrote:
> This patch adds support for of_platform_driver to the ipmi_si module.
> When loading the module, the driver will be registered to of_platform.
> The driver will be probed for all devices with the type ipmi. It's supporting
> devices with compatible settings ipmi-kcs, ipmi-smic and ipmi-bt.
> Only ipmi-kcs could be tested.
> 
> Signed-off-by: Christian Krafft <krafft@de.ibm.com>
> Acked-by: Heiko J Schick <schihei@de.ibm.com>
> Signed-off-by: Corey Minyard <minyard@acm.org>

Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Of course, the subject line is wrong, but I guess Corey can
fix that up to come out as 'ipmi: add support for of_device probing'
or something like that.

	Arnd <><
