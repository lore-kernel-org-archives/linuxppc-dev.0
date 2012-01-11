Return-Path: <Farrukh_Arshad@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "relay1.mentorg.com",
 Issuer "Entrust Certification Authority - L1B" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 519D8B6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2012 18:08:32 +1100 (EST)
From: "Arshad, Farrukh" <Farrukh_Arshad@mentor.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: OpenPIC warnings on P1022RDK AMP configuration
Date: Wed, 11 Jan 2012 07:08:20 +0000
Message-ID: <93CD5F41FDBC6042A6B449764F3B35CC050CD2A0@EU-MBX-03.mgc.mentorg.com>
References: <93CD5F41FDBC6042A6B449764F3B35CC050CD17A@EU-MBX-03.mgc.mentorg.com>
 <4F0CA749.3000306@freescale.com>
In-Reply-To: <4F0CA749.3000306@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>> Does each dtb have the correct CPU number, both from the command line bo=
ot cpu flag and in the CPU node?
Yes both CPUs have the correct CPU numbers and also both DTBs are build wit=
h their respective -b flag.=20

>> Do both device trees have pic-no-reset in the mpic node?
Yes, both have pic-no-reset mode.

>> If neither of those are the issue, start dumping the relevant MPIC inter=
rupt destination registers, and tracethe code where they're supposed to be =
set up.  Also make sure that no interrupts are  enabled when Linux receives=
 control from U-Boot.

Yes, interrupts are disabled when Linux receives control from U-Boot.
