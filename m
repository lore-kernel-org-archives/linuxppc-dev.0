Return-Path: <monstr@monstr.eu>
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
 [209.85.217.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B01302C00C6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2012 03:05:19 +1100 (EST)
Received: by mail-lb0-f179.google.com with SMTP id gm13so2011819lbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2012 08:05:16 -0800 (PST)
Message-ID: <50C60839.70603@monstr.eu>
Date: Mon, 10 Dec 2012 17:05:13 +0100
From: Michal Simek <monstr@monstr.eu>
MIME-Version: 1.0
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: pci and pcie device-tree binding - range No cells
References: <50C5D387.90908@monstr.eu> <50C5F11D.9060006@gmail.com>
 <50C5FA3E.9030303@monstr.eu> <50C5FE0F.3050108@gmail.com>
 <50C601B6.2080107@monstr.eu>
 <AE90C24D6B3A694183C094C60CF0A2F6026B70E7@saturn3.aculab.com>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B70E7@saturn3.aculab.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
 Thierry Reding <thierry.reding@avionic-design.de>,
 Rob Herring <rob.herring@calxeda.com>, Rob Herring <robherring2@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Reply-To: monstr@monstr.eu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/10/2012 04:52 PM, David Laight wrote:
>> Does it mean that pci is supposed be always 64 bit wide?
>> And there is no option to have just 32bit values.
>
> I certainly believe that all PCIe (not PCI) transfers are
> nominally multiples of 64bit data.

And PCI? That powerpc/pci-common code was designed for PCI
and microblaze also used it for PCI.

CC: Thomas: I think it will be interesting to see this discussion
because you are using size-cell/address-cells equal 1.
http://www.spinics.net/lists/arm-kernel/msg211839.html

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
