Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 97322DDEC8
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 16:57:19 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l0B5vIOt026662
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 22:57:18 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l0B5vFVV013801
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 23:57:17 -0600 (CST)
Subject: Re: [PATCH] powerpc: Fix irq routing on some PowerMac 32 bits
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1168494005.22458.401.camel@localhost.localdomain>
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
	<1168494005.22458.401.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1168495096.6644.8.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 11 Jan 2007 13:58:16 +0800
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

On Thu, 2007-01-11 at 13:40, Benjamin Herrenschmidt wrote:
> > urgent for me too. I'll do it now. Let's see ...
> 
> I beat you at it :-)
You win, then I can see PCI-to-PCI bridge in device tree.  It may be
reasonable to add a node for it.
>  Besides, I think that "sanity check" was bogus for
> other reasons anyway. It would break support for the chaos brige on
> older Apple powermacs which used the device-type "vci" instead of PCI.
Agree to move them!
If I fix the bug, I might test np and then return. So you are the first
is not a bad thing for us.
Roy
