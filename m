Return-Path: <geert@linux-m68k.org>
Received: from newton.telenet-ops.be (newton.telenet-ops.be [195.130.132.45])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vh1x835G6zDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 00:26:36 +1100 (AEDT)
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be
 [IPv6:2a02:1800:110:4::f00:19])
 by newton.telenet-ops.be (Postfix) with ESMTPS id 3vh1kQ0XYJzMr2bv
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Mar 2017 14:17:18 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 16/23] MAINTAINERS: Add file patterns for powerpc device
 tree bindings
Date: Sun, 12 Mar 2017 14:17:00 +0100
Message-Id: <1489324627-19126-17-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1489324627-19126-1-git-send-email-geert@linux-m68k.org>
References: <1489324627-19126-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Submitters of device tree binding documentation may forget to CC
the subsystem maintainer if this is missing.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
---
Please apply this patch directly if you want to be involved in device
tree binding documentation for your subsystem.

v2:
  - Rebased on top of commit a42715830d552d7c ("MAINTAINERS: Remove
    powerpc's "opal" pattern match), which just added "powerpc/opal",
    while obviously the whole "powerpc" hierarchy is of interest.

Impact on next-20170310:

-Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS,commit_signer:11/11=100%)
+Benjamin Herrenschmidt <benh@kernel.crashing.org> (supporter:LINUX FOR POWERPC (32-BIT AND 64-BIT))
+Paul Mackerras <paulus@samba.org> (supporter:LINUX FOR POWERPC (32-BIT AND 64-BIT))
+Michael Ellerman <mpe@ellerman.id.au> (supporter:LINUX FOR POWERPC (32-BIT AND 64-BIT))
+Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
 Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
-Scott Wood <oss@buserror.net> (commit_signer:5/11=45%)
-Zhao Qiang <qiang.zhao@nxp.com> (commit_signer:4/11=36%,authored:4/11=36%)
-Michael Ellerman <mpe@ellerman.id.au> (commit_signer:3/11=27%)
-Christian Lamparter <chunkeey@googlemail.com> (commit_signer:1/11=9%)
-yangbo lu <yangbo.lu@nxp.com> (authored:1/11=9%)
-"Otto Kekäläinen" <otto@seravo.fi> (authored:1/11=9%)
-Chris Packham <chris.packham@alliedtelesis.co.nz> (authored:1/11=9%)
-York Sun <york.sun@nxp.com> (authored:1/11=9%)
+linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND 64-BIT))
 devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
 linux-kernel@vger.kernel.org (open list)
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 896d7238f3f3f4e5..551ab8e4b771bcc2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7494,7 +7494,7 @@ Q:	http://patchwork.ozlabs.org/project/linuxppc-dev/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 S:	Supported
 F:	Documentation/ABI/stable/sysfs-firmware-opal-*
-F:	Documentation/devicetree/bindings/powerpc/opal/
+F:	Documentation/devicetree/bindings/powerpc/
 F:	Documentation/devicetree/bindings/rtc/rtc-opal.txt
 F:	Documentation/devicetree/bindings/i2c/i2c-opal.txt
 F:	Documentation/powerpc/
-- 
2.7.4
