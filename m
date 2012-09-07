Return-Path: <bhelgaas@google.com>
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
 [209.85.217.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ECF7F2C008F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Sep 2012 08:08:51 +1000 (EST)
Received: by lbao2 with SMTP id o2so111021lba.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Sep 2012 15:08:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3E027F8168735B46AC006B1D0C7BB002079D6153@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1342591614-1840-1-git-send-email-Shengzhou.Liu@freescale.com>
 <3F453DDFF675A64A89321A1F35281021771A8B@039-SN1MPN1-003.039d.mgd.msft.net>
 <3E027F8168735B46AC006B1D0C7BB002079D6153@039-SN2MPN1-012.039d.mgd.msft.net>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 7 Sep 2012 15:08:26 -0700
Message-ID: <CAErSpo78VePbVtz1CQrKA5f6tmpU7v_qY6ZYozh9FrW-m0g2rA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: use dev->irq instead of dev->pin to enable non
 MSI/INTx interrupt
To: Zang Roy-R61911 <r61911@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Liu Shengzhou-B36685 <B36685@freescale.com>,
 Wood Scott-B07421 <B07421@freescale.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 6, 2012 at 8:45 PM, Zang Roy-R61911 <r61911@freescale.com> wrote:
>
>
>> -----Original Message-----
>> From: Linuxppc-dev [mailto:linuxppc-dev-bounces+tie-
>> fei.zang=freescale.com@lists.ozlabs.org] On Behalf Of Liu Shengzhou-B36685
>> Sent: Thursday, July 26, 2012 11:45 AM
>> To: bhelgaas@google.com; linux-pci@vger.kernel.org; akpm@linux-
>> foundation.org
>> Cc: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org; Liu Shengzhou-B36685
>> Subject: RE: [PATCH v2] PCI: use dev->irq instead of dev->pin to enable non
>> MSI/INTx interrupt
>>
>> Hello,
>>
>> A gentle reminder!
>> Any comments are appreciated.
>
> Who can help to review and pick up this patch?

I merged this to a staging branch and will merge it to my "next"
branch as soon as it gets a build/smoke test by Fengguang.  Thanks!

Bjorn
