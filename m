Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yprhN71zrzDrvM
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Dec 2017 23:54:57 +1100 (AEDT)
Subject: [PATCH] SB600 for the Nemo board has non-zero devices on non-root bus
To: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Olof Johansson <olof@lixom.net>, Darren Stevens <darren@stevens-zone.net>
References: <f3513294-6da0-456f-0f98-1f8c3bac90c9@xenosoft.de>
 <87tvxl15qx.fsf@concordia.ellerman.id.au>
 <4cfe3cc0-7fe3-9774-7d20-1b7fcb7aa910@xenosoft.de>
 <CAErSpo55Q8Q=5p6_+uu7ahnw+53ibVDNRXxrzRV9QnUr_9EUfw@mail.gmail.com>
 <28b43e1a-3643-9edb-7123-be1cb0dc846a@xenosoft.de>
 <CAErSpo7fup7+doD6A7RKh8kdE8HQaQrEh=gq35+nC-dBeOQ1uA@mail.gmail.com>
 <527175f7-8a13-37a1-9f0a-0b918aeebd64@xenosoft.de>
 <20171130224243.GB19640@bhelgaas-glaptop.roam.corp.google.com>
 <406ba7c4-7305-4069-227f-81afed202e47@xenosoft.de>
 <20171201232716.GA18780@bhelgaas-glaptop.roam.corp.google.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <6d2505ab-a985-bdb0-ad3a-e7659cc2c54d@xenosoft.de>
Date: Sat, 2 Dec 2017 13:54:41 +0100
MIME-Version: 1.0
In-Reply-To: <20171201232716.GA18780@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02 December 2017 at 00:27AM, Bjorn Helgaas wrote:
>
> Thanks for testing that.  I'll merge a similar patch for v4.16.
>
> I don't think using "pci=pcie_scan_all" is really an acceptable
> long-term answer for you, though.  Is there some way we can identify
> at run-time whether we're on a Nemo system?  If so, we can make this
> happen automatically.
>
> Bjorn
>
Hi Bjorn,

Many thanks for your effort! I appreciate it very much. :-)

We can identify the Nemo board at the boot time. See dmesg output: [    
0.061592] NEMO SB600 IOB base e0000000

@linuxppc-dev
Any other ideas? Maybe the same as we can identify the other P.A. Semi 
boards (Electra, Chitra, and Athena).

@Olof
Maybe you know how we can identify the P.A. Semi Nemo board at the run-time.

@Darren
Do you have an idea?

Thanks to all for your help.

Cheers,
Christian
