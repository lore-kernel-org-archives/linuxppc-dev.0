Return-Path: <scottwood@freescale.com>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe001.messaging.microsoft.com
	[213.199.154.204])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 28774B7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Dec 2010 06:04:32 +1100 (EST)
Date: Mon, 20 Dec 2010 12:49:11 -0600
From: Scott Wood <scottwood@freescale.com>
To: "Dry, Craig" <cdry@mc.com>
Subject: Re: P2020 with BCM53115
Message-ID: <20101220124911.141ce72d@udp111988uds.am.freescale.net>
In-Reply-To: <690FFE9537DC4C47854ABD6C16FA141945A2AC3D5F@CHM-MBX1.ad.mc.com>
References: <690FFE9537DC4C47854ABD6C16FA141945A2AC3D5F@CHM-MBX1.ad.mc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 20 Dec 2010 13:08:55 -0500
"Dry, Craig" <cdry@mc.com> wrote:

> I am trying to bring up a P2020 board which uses the Broadcom BCM53115 switch in unmanaged mode.  The board is patterned after the P2020RDB, except the Vitesse switch has been replaced with a BCM53115. There is no MDIO connection to the switch, but there is  an SPI connection available if needed.
> 
> When running Uboot, the BCM53115 works just fine, as I am able to download the Linux Kernel and P2020RDB.dtb across the network without issue.   But as Linux is booting up, I get the message:
> 
> mdio_bus mdio@ffe24520: error probing PHY at address 0
> mdio_bus mdio@ffe24520: error probing PHY at address 1
> 
> I expect these errors occur because the P2020RDB.dts file has these entries.
> 
> I'm not sure what to try next to get Linux to use the BCM53115 switch in unmanaged mode.

See the fixed-link property in
Documentation/powerpc/dts-bindings/fsl/tsec.txt

-Scott
