Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 51C6ADE113
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 02:03:09 +1000 (EST)
Message-ID: <486BA6B0.8060708@scram.de>
Date: Wed, 02 Jul 2008 18:02:56 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc: fix section numbering of CPM chapter in
	booting-without-of.
Content-Type: text/plain; charset=ISO-8859-15
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Within the Freescale Communications Processor Module chapter, both
Serial and Network have the same section number iii). Renumber the
sections to make them unique again.

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 Documentation/powerpc/booting-without-of.txt |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 1d2a772..d9dc996 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1992,7 +1992,7 @@ platforms are moved over to use the flattened-device-tree model.
 		fsl,cpm-command = <00800000>;
 	};

-   iii) Network
+   iv) Network

    Currently defined compatibles:
    - fsl,cpm1-scc-enet
@@ -2015,7 +2015,7 @@ platforms are moved over to use the flattened-device-tree model.
 		fsl,cpm-command = <12000300>;
 	};

-   iv) MDIO
+   v) MDIO

    Currently defined compatibles:
    fsl,pq1-fec-mdio (reg is same as first resource of FEC device)
@@ -2039,7 +2039,7 @@ platforms are moved over to use the flattened-device-tree model.
 		fsl,mdc-pin = <13>;
 	};

-   v) Baud Rate Generators
+   vi) Baud Rate Generators

    Currently defined compatibles:
    fsl,cpm-brg
@@ -2062,7 +2062,7 @@ platforms are moved over to use the flattened-device-tree model.
 		clock-frequency = <d#25000000>;
 	};

-   vi) Interrupt Controllers
+   vii) Interrupt Controllers

    Currently defined compatibles:
    - fsl,cpm1-pic
@@ -2082,7 +2082,7 @@ platforms are moved over to use the flattened-device-tree model.
 		compatible = "mpc8272-pic", "fsl,cpm2-pic";
 	};

-   vii) USB (Universal Serial Bus Controller)
+   viii) USB (Universal Serial Bus Controller)

    Properties:
    - compatible : "fsl,cpm1-usb", "fsl,cpm2-usb", "fsl,qe-usb"
@@ -2098,7 +2098,7 @@ platforms are moved over to use the flattened-device-tree model.
 		fsl,cpm-command = <2e600000>;
 	};

-   viii) Multi-User RAM (MURAM)
+   ix) Multi-User RAM (MURAM)

    The multi-user/dual-ported RAM is expressed as a bus under the CPM node.

-- 
1.5.6
