Return-Path: <Emilian.Medve@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5DFC11A0517
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Nov 2014 02:28:10 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0136.outbound.protection.outlook.com [157.56.111.136])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5C1711400D2
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Nov 2014 02:28:08 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <scottwood@Freescale.com>, <galak@kernel.crashing.org>, <corbet@lwn.net>,
 <robh+dt@kernel.org>, <ijc+devicetree@hellion.org.uk>,
 <galak@codeaurora.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
 <grant.likely@linaro.org>, <Geoff.Thorpe@Freescale.com>,
 <linuxppc-dev@ozlabs.org>, <devicetree@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: [PATCH v3 0/4] dt/bindings: Introduce the FSL QorIQ DPAA B/QMan
Date: Wed, 5 Nov 2014 09:18:50 -0600
Message-ID: <1415200734-6978-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Emil Medve <Emilian.Medve@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Outstanding topics:
	- Scott's reserved-memory updates proposal
	- Some LIODN loose ends
	- Private memory sizing

v3: Address feedback from Kumar Gala
	- Move bindings from Documentation/devicetree/bindings/powerpc/fsl to
	  Documentation/devicetree/bindings/soc/fsl to support ARM based SoC(s)
	- Add phandles to link the reserved-memory to the B/QMan nodes to support
	  multiple B/QMan nodes per SoC
	- Better handle acronyms
    Address feedback from Scott Wood
    	- Spelling error
	- Extra phandles to reflect DPAA blocks links to the B/QMan nodes in
	  order to support multiple B/QMan nodes per SoC
	- Add version register(s) information to highlight differences in the
	  programming model
	- Detail LIODN types/usage
	- Update nodes names without a 'reg' property

v2: Incorporate feedback from Mark Rutland
	- Remove "subject to change" notes
	- Add/document the 'interrupts' properties
	- Make multiple windows 'reg' properties more readable
	- Improve portal description

Emil Medve (4):
  dt/bindings: Introduce the FSL QorIQ DPAA BMan
  dt/bindings: Introduce the FSL QorIQ DPAA BMan portal(s)
  dt/bindings: Introduce the FSL QorIQ DPAA QMan
  dt/bindings: Introduce the FSL QorIQ DPAA QMan portal(s)

 .../devicetree/bindings/soc/fsl/bman-portals.txt   |  56 +++++++
 Documentation/devicetree/bindings/soc/fsl/bman.txt | 125 ++++++++++++++++
 .../devicetree/bindings/soc/fsl/qman-portals.txt   | 154 +++++++++++++++++++
 Documentation/devicetree/bindings/soc/fsl/qman.txt | 165 +++++++++++++++++++++
 4 files changed, 500 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/bman-portals.txt
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/bman.txt
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/qman-portals.txt
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/qman.txt

-- 
2.1.3
