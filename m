Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 02490DE03A
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Mar 2007 01:38:07 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l2NEc1Nr016312
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 07:38:02 -0700 (MST)
Message-ID: <4603E648.4030907@freescale.com>
Date: Fri, 23 Mar 2007 09:38:00 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jon Loeliger <jdl@freescale.com>, linuxppc-dev@ozlabs.org
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
In-Reply-To: <20070323032214.GC28006@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:

> Well, that's part of why I'm contemplating this idea:  it makes it
> clear to the reader whether this dts is intended to be complete, or
> whether it's intended that the bootloader adjust things.

I would have no objection to a patch for DTC that makes it treat "?" 
like "0".  This would probably make everyone happy.
