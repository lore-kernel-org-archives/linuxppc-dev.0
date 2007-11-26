Return-Path: <sfalco@harris.com>
Received: from mlbe2k1.cs.myharris.net (mlbe2k1.cs.myharris.net
	[137.237.90.88]) by ozlabs.org (Postfix) with ESMTP id B0114DDE03
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 09:46:04 +1100 (EST)
Message-ID: <474B4CA9.3070506@harris.com>
Date: Mon, 26 Nov 2007 17:46:01 -0500
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: Sequoia EMAC only works if u-boot initializes it?
References: <474AED67.4020006@harris.com> <200711261720.26629.sr@denx.de>	
	<474B1A11.90806@harris.com> <1196107715.7195.107.camel@pasglop>
In-Reply-To: <1196107715.7195.107.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

With the following 15 patches on top of the DENX git tree, I have both emac ports working:

 1) [PATCH 2/2] PowerPC: Fix Sequoia MAL0 and EMAC dts entries.
 2) [PATCH] PowerPC: Add RGMII support for Sequoia 440EPx
 3) [PATCH] Fix typo in new EMAC driver.
 4) PowerPC: Enable NEW EMAC support for Sequoia 440EPx.

 5) [PATCH 1/8] ibm_newemac: Fix possible lockup on close
 6) [PATCH 2/8] ibm_newemac: Add BCM5248 and Marvell 88E1111 PHY support
 7) [PATCH 3/8] ibm_newemac: Add ET1011c PHY support
 8) [PATCH 4/8] ibm_newemac: Fix ZMII refcounting bug
 9) [PATCH 5/8] ibm_newemac: Workaround reset timeout when no link
10) [PATCH 6/8] ibm_newemac: Cleanup/Fix RGMII MDIO support detection
11) [PATCH 7/8] ibm_newemac: Cleanup/fix support for STACR register variants
12) [PATCH 8/8] ibm_newemac: Skip EMACs that are marked unused by the firmware

13) [PATCH 1/3] PowerPC: ibm_newemac correct opb_bus_freq value
14) [PATCH 2/3] PowerPC: ibm_newemac tah_ph typo fix
15) [PATCH 3/3] PowerPC: ibm_newemac call dev_set_drvdata() before tah_reset()

	Steve


Benjamin Herrenschmidt wrote:
> On Mon, 2007-11-26 at 14:10 -0500, Steven A. Falco wrote:
>> I've attached a copy of my bootlog.  I added in one patch to enable
>> rgmii but that didn't fix
>> it.(http://ozlabs.org/pipermail/linuxppc-dev/2007-October/043435.html)
>>
>> I am curious why the new emac driver is enabled in the DENX tree but
>> not in the upstream trees.  Has DENX successfully used this driver on
>> the Sequoia board?  Am I trying something that is known not to work?
>>
>> I'm interested in helping in whatever way I can.  I need ARCH=powerpc
>> to use the current Xenomai patches, and I need both EMACs so I can
>> evaluate bonding (for high-availability).
> 
> Have you tried adding the various patches I posted along with the
> patches Valentine posted ?
> 
> I'll re-send a full serie later this week. Let us know if those help or
> if something is still broken.
> 
> Cheers,
> Ben.
> 
> 
> 
