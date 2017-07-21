Return-Path: <ivan@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDW1t0CQXzDqv4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 22:54:41 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6LCrnRm131716
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 08:54:38 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2buh1rtg5c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 08:54:37 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ivan@de.ibm.com>;
 Fri, 21 Jul 2017 13:54:35 +0100
From: Ivan Mikhaylov <ivan@de.ibm.com>
To: Ian Campbell <ijc@hellion.org.uk>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/44x/fsp2: correct dtb reg property for
 /sdhci@020c0000
Date: Fri, 21 Jul 2017 15:54:27 +0300
In-Reply-To: <20170715090302.23105-1-ijc@hellion.org.uk>
References: <20170715090302.23105-1-ijc@hellion.org.uk>
Message-Id: <20170721125427.77668-1-ivan@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ian,
>Building the split device-tree tree[0] highlighted that upstream commit
>9eec6cb142bd ("powerpc/44x/fsp2: Add device tree for FSP2 board") introduced
>this warning when building the device tree:
>
>$ make CROSS_COMPILE=powerpc-linux-gnu- ARCH=powerpc fsp2.dtb
>  CHK     scripts/mod/devicetable-offsets.h
>  DTC     arch/powerpc/boot/fsp2.dtb
>arch/powerpc/boot/fsp2.dtb: Warning (reg_format): "reg" property in /sdhci@020c0000 has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
>
>This commit adds the second adress cell as zeroes to resolve the warning. Note:
>I have no access to or information about this platform so this is purely a
>guess as to the fix. An alternative would be to adjust #address-cells, but
>whether that is correct or not depends on the platform.

Yes, this problem exists on this tag but it is already fixed and waiting for
review by this https://patchwork.kernel.org/patch/9819379/ . You can check it
if you want, anyways it will go to powerpc next branch first.

Thank you.
