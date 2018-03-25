Return-Path: <darren@stevens-zone.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 408V9D57bKzF1ww
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 08:02:56 +1100 (AEDT)
From: Darren Stevens <darren@stevens-zone.net>
To: Michael Ellerman <mpe@ellerman.id.au>
CC: Bjorn Helgaas <helgaas@kernel.org>,
 Christian Zigotzky <chzigotzky@xenosoft.de>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Olof Johansson <olof@lixom.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Sun, 25 Mar 2018 21:55:45 +0100 (BST)
Message-ID: <4babdbb48e2.680f246e@auth.smtp.1and1.co.uk>
In-Reply-To: <87tvtbg0i9.fsf@concordia.ellerman.id.au>
References: <4cfe3cc0-7fe3-9774-7d20-1b7fcb7aa910@xenosoft.de>
 <CAErSpo55Q8Q=5p6_+uu7ahnw+53ibVDNRXxrzRV9QnUr_9EUfw@mail.gmail.com>
 <28b43e1a-3643-9edb-7123-be1cb0dc846a@xenosoft.de>
 <CAErSpo7fup7+doD6A7RKh8kdE8HQaQrEh=gq35+nC-dBeOQ1uA@mail.gmail.com>
 <527175f7-8a13-37a1-9f0a-0b918aeebd64@xenosoft.de>
 <20171130224243.GB19640@bhelgaas-glaptop.roam.corp.google.com>
 <406ba7c4-7305-4069-227f-81afed202e47@xenosoft.de>
 <20171201232716.GA18780@bhelgaas-glaptop.roam.corp.google.com>
 <dc228918-652a-e24c-ce7b-8d1b30153d3b@xenosoft.de>
 <639e975f-1b3a-4f85-9a40-13fe2473fc28@xenosoft.de>
 <20180319191310.GG77194@bhelgaas-glaptop.roam.corp.google.com>
 <87tvtbg0i9.fsf@concordia.ellerman.id.au>
Subject: Re: PCI set flag PCI_SCAN_ALL_PCIE_DEVS for P.A. Semi boards
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Michael

On 20/03/2018, Michael Ellerman wrote:
>> The patch looks fine, but I need a signed-off-by line before I can apply
>> it.  See https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst
>
> I'm happy to take it, I've been meaning to check if Olof sent a SOB in
> his original mail but haven't got to it.

If thats the way you want to go... We still have an out-of-tree patch we need to apply, which I think is the right place for this. In fact I submitted some patches at the end of last year with a cleaned up version (including the above patch). Here are links:

https://patchwork.ozlabs.org/patch/854270/
https://patchwork.ozlabs.org/patch/854269/
https://patchwork.ozlabs.org/patch/854271/
https://patchwork.ozlabs.org/patch/854268/

These seem to have been missed somehow. (I intended them for 4.16)

If these are suitable, the only thing left would be the pasemi i2c bus patch, which keeps getting ignored by the i2c guys.

Regards
Darren
