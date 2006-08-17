Return-Path: <shawnxjin@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.180])
	by ozlabs.org (Postfix) with ESMTP id 516CF67B32
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 05:01:49 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id f25so785338pyf
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 12:01:48 -0700 (PDT)
Message-ID: <c3d0340b0608171201t1768f60l5ba7b247f8c5fdfc@mail.gmail.com>
Date: Thu, 17 Aug 2006 12:01:48 -0700
From: "Shawn Jin" <shawnxjin@gmail.com>
To: ppcdev <linuxppc-dev@ozlabs.org>
Subject: PCIe enhanced configuration mechanism support on ppc arch
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I'm trying to find out if the current PCI subsystem supports the PCIe
enhanced configuration mechanism, in particular, on the ppc/powerpc
arch, which is basically a MMIO access with the address containing all
bus, device, function, and offset info.

Could someone here give an authoritative answer? Or point me to
somewhere I can look for it by myself, such as which file or directory
in the kernel tree. I searched at arch/ppc/kernel,
arch/powerpc/kernel, and drivers/pci but couldn't find an answer. :(

Thanks,
-Shawn.
