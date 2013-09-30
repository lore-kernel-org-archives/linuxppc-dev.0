Return-Path: <B31939@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0250.outbound.messaging.microsoft.com [213.199.154.250])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 92E152C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Sep 2013 11:51:06 +1000 (EST)
Message-ID: <5248D94E.7080904@freescale.com>
Date: Mon, 30 Sep 2013 09:52:14 +0800
From: Lian Minghuan-b31939 <B31939@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@tabi.org>, Minghuan Lian <Minghuan.Lian@freescale.com>
Subject: Re: [PATCH 2/2] pci: fsl: rework PCI driver compatible with Layerscape
References: <1379502122-20792-1-git-send-email-Minghuan.Lian@freescale.com>	<1379502122-20792-2-git-send-email-Minghuan.Lian@freescale.com>
 <CAOZdJXUF3ibW5iuB-2p5bhPp-Uw9MVKzqZiDdukMfi4f1d3Phw@mail.gmail.com>
In-Reply-To: <CAOZdJXUF3ibW5iuB-2p5bhPp-Uw9MVKzqZiDdukMfi4f1d3Phw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Zang Roy-R61911 <r61911@freescale.com>, Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Timur,

Thanks for your comments.

How about PCI_FSL_COMMON?

Thanks,
Minghuan

On 09/30/2013 07:56 AM, Timur Tabi wrote:
> On Wed, Sep 18, 2013 at 6:02 AM, Minghuan Lian
> <Minghuan.Lian@freescale.com> wrote:
>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 38f3b7e..6fd6348 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -690,6 +690,7 @@ config FSL_SOC
>>
>>   config FSL_PCI
>>          bool
>> +       select PCI_FSL if FSL_SOC_BOOKE || PPC_86xx
> I think having two config options, one called FSL_PCI and the other
> PCI_FSL, is very confusing.  Surely, you can pick better names than
> that?
>
