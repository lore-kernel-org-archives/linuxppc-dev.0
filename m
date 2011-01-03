Return-Path: <grant.likely@secretlab.ca>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 69036B6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Jan 2011 09:06:08 +1100 (EST)
Received: by iwn42 with SMTP id 42so15183751iwn.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 03 Jan 2011 14:06:05 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
Subject: [PATCH] powerpc/405: Fix missing #{address,size}-cells in i2c node
To: linuxppc-dev@lists.ozlabs.org, jwboyer@linux.vnet.ibm.com,
	solomon@linux-wlan.com
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 03 Jan 2011 15:06:03 -0700
Message-ID: <20110103220520.9355.2745.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

I'm putting this patch into my next-devicetree branch.

g.

 arch/powerpc/boot/dts/hotfoot.dts |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/hotfoot.dts b/arch/powerpc/boot/dts/hotfoot.dts
index cad9c38..71d3bb4 100644
--- a/arch/powerpc/boot/dts/hotfoot.dts
+++ b/arch/powerpc/boot/dts/hotfoot.dts
@@ -117,6 +117,8 @@
 			};
 
 			IIC: i2c@ef600500 {
+				#address-cells = <1>;
+				#size-cells = <0>;
 				compatible = "ibm,iic-405ep", "ibm,iic";
 				reg = <0xef600500 0x00000011>;
 				interrupt-parent = <&UIC0>;
