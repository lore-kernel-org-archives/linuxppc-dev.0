Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 13FADDDE05
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 16:35:21 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l0B5ZK6w019839
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 22:35:20 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l0B5ZHMh009073
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 23:35:18 -0600 (CST)
Subject: Re: [PATCH] powerpc: Fix irq routing on some PowerMac 32 bits
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1168493297.22458.394.camel@localhost.localdomain>
References: <1165806548.7260.0.camel@localhost.localdomain>
	<1168398002.571.3.camel@localhost.localdomain>
	<1168399012.22458.328.camel@localhost.localdomain>
	<1168400086.700.12.camel@localhost.localdomain>
	<1168401489.22458.332.camel@localhost.localdomain>
	<1168419440.1704.16.camel@localhost.localdomain>
	<1168431197.22458.336.camel@localhost.localdomain>
	<1168493104.6411.10.camel@localhost.localdomain>
	<1168493297.22458.394.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1168493777.6545.3.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 11 Jan 2007 13:36:18 +0800
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

On Thu, 2007-01-11 at 13:28, Benjamin Herrenschmidt wrote:
> > The problem was induced by PCI bridge just as Haiying explained.
> Until
> > now, we do not describe PCI bridge in device tree. Only PCI host has
> the
> > "reg" property. We can not identify the PCI device on bus 0 or bus 1
> by
> > node in device tree. The difference between device tree and OF might
> > introduce potential bugs for PCI bus. We should consider the
> difference.
> 
> That's fine, there is no problem in doing that, though I do recommend
> as
> a general rule to put PCI-to-PCI bridges that are soldered on the
> board
> in the device-tree,
I agree! I will try to improve PCI-to-PCI bridges description on my 85xx
CDS board support.
Hope to get your support about OF.
>  you don't absolutely have to.
>  
> > > In any case, a patch is definitely needed to properly check for
> NULL
> > > and
> > > should get into 2.6.20, so if you want to do it, it will be much
> > > welcome !
> > I will provide it later.
> 
> This urgent, I'll do a patch myself and send it to paulus.
urgent for me too. I'll do it now. Let's see ...
Roy
