Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 21217B7BE1
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Dec 2009 23:08:06 +1100 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e32.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nB4C2W6R004791
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Dec 2009 05:02:32 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nB4C7l5X119594
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Dec 2009 05:07:47 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nB4C7lV4004278
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Dec 2009 05:07:47 -0700
Date: Fri, 4 Dec 2009 07:07:44 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Curtis Wald <CWald@WatchGuardVideo.com>
Subject: Re: [PATCH] POWERPC 4xx: Fix PCI in AMCC 440EP Yosemite DTS
Message-ID: <20091204120744.GI2937@zod.rchland.ibm.com>
References: <13F6A75BE29CE44F801B912901C3EF27022A3993@wgv4.watchguardvideo.local>
	<20091130134145.GA2937@zod.rchland.ibm.com>
	<13F6A75BE29CE44F801B912901C3EF270233B6A4@wgv4.watchguardvideo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <13F6A75BE29CE44F801B912901C3EF270233B6A4@wgv4.watchguardvideo.local>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 30, 2009 at 09:25:51AM -0600, Curtis Wald wrote:
>Josh,
>Here is a resend of the Yosemite.dts patch, deleting tabs and spaces in
>the IDSEL section that should look better when viewing as 80 column. 

Something is still eating your patches when you send them out.  They get
corrupted to the point of being unusable as you can see here:

http://patchwork.ozlabs.org/patch/39810/

However, your intentions are pretty clear.  Could you look at the patch below
and see if it was what you intended?  If so, I'll include it in my 'next'
branch today.

josh

---

diff --git a/arch/powerpc/boot/dts/yosemite.dts b/arch/powerpc/boot/dts/yosemite.dts
index 1fa3cb4..6492324 100644
--- a/arch/powerpc/boot/dts/yosemite.dts
+++ b/arch/powerpc/boot/dts/yosemite.dts
@@ -282,20 +282,10 @@
 			/* Inbound 2GB range starting at 0 */
 			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x80000000>;
 
-			/* Bamboo has all 4 IRQ pins tied together per slot */
 			interrupt-map-mask = <0xf800 0x0 0x0 0x0>;
 			interrupt-map = <
-				/* IDSEL 1 */
-				0x800 0x0 0x0 0x0 &UIC0 0x1c 0x8
-
-				/* IDSEL 2 */
-				0x1000 0x0 0x0 0x0 &UIC0 0x1b 0x8
-
-				/* IDSEL 3 */
-				0x1800 0x0 0x0 0x0 &UIC0 0x1a 0x8
-
-				/* IDSEL 4 */
-				0x2000 0x0 0x0 0x0 &UIC0 0x19 0x8
+				/* IDSEL 12 */
+				0x6000 0x0 0x0 0x0 &UIC0 0x19 0x8
 			>;
 		};
 	};
