Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id EEF4DDDF11
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 05:17:34 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l2KIHVAQ014242
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 11:17:31 -0700 (MST)
Subject: Re: [PATCH 10/17] bootwrapper: Add dt_set_mac_addresses().
From: Jon Loeliger <jdl@freescale.com>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <45FEA7B3.9090304@freescale.com>
References: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
	<20070316172853.GJ29784@ld0162-tx32.am.freescale.net>
	<20070317013159.GH3969@localhost.localdomain>
	<45FC8643.1080807@freescale.com>
	<20070318115656.GA12765@localhost.localdomain>
	<45FEA7B3.9090304@freescale.com>
Content-Type: text/plain
Message-Id: <1174414649.6595.422.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Tue, 20 Mar 2007 13:17:29 -0500
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-03-19 at 10:09, Timur Tabi wrote:

> Obviously, the DTS files shouldn't have mac-address in them.  But I haven't gotten around 
> to cleaning that up, because I'm still waiting for the U-Boot maintainers to apply my 
> pre-requisite patches.

Some U-Boot Maintainers are still waiting for respun
patches that apply cleanly. :-)

jdl
