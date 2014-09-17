Return-Path: <thomas.petazzoni@free-electrons.com>
Received: from mail.free-electrons.com (top.free-electrons.com [176.31.233.9])
 by lists.ozlabs.org (Postfix) with ESMTP id 99D111A007F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Sep 2014 01:26:03 +1000 (EST)
Date: Wed, 17 Sep 2014 17:25:58 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH v2 0/3] PCI/MSI: Remove arch_msi_check_device()
Message-ID: <20140917172558.5847e16f@free-electrons.com>
In-Reply-To: <cover.1410078503.git.agordeev@redhat.com>
References: <cover.1410078503.git.agordeev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Lior Amsalem <alior@marvell.com>, Jason Cooper <jason@lakedaemon.net>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nadav Haklai <nadavh@marvell.com>,
 Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
 Gregory =?UTF-8?B?Q2zDqW1lbnQ=?= <gregory.clement@free-electrons.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Alexander Gordeev,

On Sun,  7 Sep 2014 20:57:52 +0200, Alexander Gordeev wrote:

> Alexander Gordeev (3):
>   patch 1 - PCI/MSI/PPC: Remove arch_msi_check_device()
>   patch 2 - PCI/MSI/Armada-370-xp: Remove arch_msi_check_device()
>   patch 3 - PCI/MSI: Remove arch_msi_check_device()

For the entire series:

Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

I tested on the Armada XP GP platform, which is particularly affected
by PATCH 2/3, as it is using the irq-armada-370-xp irqchip driver. I
tested with an igb PCIe NIC that supports MSI and MSI-X, and I verified
that MSI-X is still rejected (since we don't support it on Armada XP,
at least for now), and that MSI is accepted and actually works.

Thanks for doing this, and sorry for the delay in getting the patches
tested!

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
