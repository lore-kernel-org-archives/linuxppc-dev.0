Return-Path: <sfalco@harris.com>
Received: from mlbe2k2.cs.myharris.net (mlbe2k2.cs.myharris.net
	[137.237.90.89]) by ozlabs.org (Postfix) with ESMTP id 7FE3ADDDF8
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Nov 2007 04:52:57 +1100 (EST)
Message-ID: <4728C0F5.80304@harris.com>
Date: Wed, 31 Oct 2007 13:52:53 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: PPC405GP Walnut irq patch
References: <47279CF0.4050600@harris.com>	<4727A507.10309@harris.com>
	<20071030204015.06a699d7@vader.jdub.homelinux.org>
In-Reply-To: <20071030204015.06a699d7@vader.jdub.homelinux.org>
Content-Type: multipart/mixed; boundary="------------040809010809040106080506"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040809010809040106080506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


> Could you redo the patch with just this bit and send it again?
>
> josh
>   

Ok - this one is based off the Linus tree, and follows your style of one 
interrupt per line, with a comment indicating which one it is.

Signed-off-by: Steve Falco <sfalco at harris.com>



--------------040809010809040106080506
Content-Type: text/x-patch;
 name="irq.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="irq.patch"

diff --git a/arch/powerpc/boot/dts/walnut.dts b/arch/powerpc/boot/dts/walnut.dts
index fa681f5..754fa39 100644
--- a/arch/powerpc/boot/dts/walnut.dts
+++ b/arch/powerpc/boot/dts/walnut.dts
@@ -122,7 +122,9 @@
 				device_type = "network";
 				compatible = "ibm,emac-405gp", "ibm,emac";
 				interrupt-parent = <&UIC0>;
-				interrupts = <9 4 f 4>;
+				interrupts = <
+					f 4 /* Ethernet */
+					9 4 /* Ethernet Wake Up */>;
 				local-mac-address = [000000000000]; /* Filled in by zImage */
 				reg = <ef600800 70>;
 				mal-device = <&MAL>;

--------------040809010809040106080506--
