Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 232D0DDE24
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 16:40:12 +1100 (EST)
Subject: Re: [PATCH] powerpc: Fix irq routing on some PowerMac 32 bits
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
In-Reply-To: <1168493777.6545.3.camel@localhost.localdomain>
References: <1165806548.7260.0.camel@localhost.localdomain>
	<1168398002.571.3.camel@localhost.localdomain>
	<1168399012.22458.328.camel@localhost.localdomain>
	<1168400086.700.12.camel@localhost.localdomain>
	<1168401489.22458.332.camel@localhost.localdomain>
	<1168419440.1704.16.camel@localhost.localdomain>
	<1168431197.22458.336.camel@localhost.localdomain>
	<1168493104.6411.10.camel@localhost.localdomain>
	<1168493297.22458.394.camel@localhost.localdomain>
	<1168493777.6545.3.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 11 Jan 2007 16:40:05 +1100
Message-Id: <1168494005.22458.401.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> urgent for me too. I'll do it now. Let's see ...

I beat you at it :-) Besides, I think that "sanity check" was bogus for
other reasons anyway. It would break support for the chaos brige on
older Apple powermacs which used the device-type "vci" instead of PCI.

Ben
