Return-Path: <madalin.bucur@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0119.outbound.protection.outlook.com [65.55.169.119])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7D06A1A060E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 22:42:57 +1000 (AEST)
From: Madalin Bucur <madalin.bucur@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH 0/4] Add support for DPAA on T1023RDB and T1024RDB
Date: Wed, 20 May 2015 15:41:36 +0300
Message-ID: <1432125700-7024-1-git-send-email-madalin.bucur@freescale.com>
Reply-To: <madalin.bucur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Igal.Liberman@freescale.com, roy.pledge@freescale.com,
 Madalin Bucur <madalin.bucur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These patches depend upon several other patches that are now in review:

[1] powerpc/mpc85xx: Add DPAA Ethernet QMan support to the device tree(s)
[2] powerpc/mpc85xx: Create dts components for the FSL QorIQ DPAA FMan
[3] powerpc/fsl-booke: Add T1023 RDB board support
[3] powerpc/fsl-booke: Add T1024 RDB board support
[3] powerpc/fsl-booke: Add T1024 QDS board support
[3] powerpc/fsl-booke: Add device tree support for T1024/T1023 SoC

Current patchwork links:
[1] https://patchwork.ozlabs.org/patch/474402/
[2] https://patchwork.ozlabs.org/patch/443974/
[3] http://patchwork.ozlabs.org/project/linuxppc-dev/list/?=shengzhou&submitter=8045

Madalin Bucur (4):
  powerpc/fsl-booke: Add T1023RDB QBMan device tree components
  powerpc/fsl-booke: Add T1023RDB FMan device tree components
  powerpc/fsl-booke: Add T1024RDB QBMan device tree components
  powerpc/fsl-booke: Add T1024RDB FMan device tree components

 arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi |  94 ++++++++++++++++++
 arch/powerpc/boot/dts/fsl/t1023si-post.dtsi   | 136 ++++++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi    |   6 ++
 arch/powerpc/boot/dts/t1023rdb.dts            |  69 +++++++++++++
 arch/powerpc/boot/dts/t1024rdb.dts            |  73 ++++++++++++++
 5 files changed, 378 insertions(+)
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi

-- 
1.7.11.7
