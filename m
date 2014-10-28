Return-Path: <Emilian.Medve@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0E5A11A0060
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 20:24:37 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0139.outbound.protection.outlook.com [157.56.111.139])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EDDCE140077
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2014 20:24:35 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <scottwood@Freescale.com>, <galak@kernel.crashing.org>, <corbet@lwn.net>,
 <robh+dt@kernel.org>, <ijc+devicetree@hellion.org.uk>,
 <galak@codeaurora.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
 <grant.likely@linaro.org>, <Geoff.Thorpe@Freescale.com>,
 <linuxppc-dev@ozlabs.org>, <devicetree@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: [PATCH v2 0/4] dt/bindings: Introduce the FSL B/QMan
Date: Tue, 28 Oct 2014 04:15:47 -0500
Message-ID: <1414487751-31568-1-git-send-email-Emilian.Medve@Freescale.com>
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

 .../bindings/powerpc/fsl/bman-portals.txt          |  52 +++++++
 .../devicetree/bindings/powerpc/fsl/bman.txt       |  95 +++++++++++++
 .../bindings/powerpc/fsl/qman-portals.txt          | 151 +++++++++++++++++++++
 .../devicetree/bindings/powerpc/fsl/qman.txt       | 133 ++++++++++++++++++
 4 files changed, 431 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/bman-portals.txt
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/bman.txt
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/qman-portals.txt
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/qman.txt

-- 
2.1.2
