Return-Path: <monstr@monstr.eu>
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
 [209.85.217.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 44DB42C0134
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2012 23:20:31 +1100 (EST)
Received: by mail-lb0-f179.google.com with SMTP id gm13so1821369lbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2012 04:20:27 -0800 (PST)
Message-ID: <50C5D387.90908@monstr.eu>
Date: Mon, 10 Dec 2012 13:20:23 +0100
From: Michal Simek <monstr@monstr.eu>
MIME-Version: 1.0
To: devicetree-discuss@lists.ozlabs.org,
 Grant Likely <grant.likely@secretlab.ca>,
 linux-pci@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: pci and pcie device-tree binding - range No cells
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Reply-To: monstr@monstr.eu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Grant and others,

I have a question regarding number of cells in ranges property
for pci and pcie nodes.

Linux pci/pcie powerpc DTSes contain 7 cells (xpedite5370.dts, sequoia.dts, etc)
but also 6 cells format too (mpc832x_mds.dts)

Here is shown 6 cells ranges format and describe
http://devicetree.org/Device_Tree_Usage#PCI_Host_Bridge

And also in documentation in the linux
Documentation/devicetree/bindings/pci/83xx-512x-pci.txt

Both format uses:
#size-cells = <2>;
#address-cells = <3>;

What is valid format?

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
