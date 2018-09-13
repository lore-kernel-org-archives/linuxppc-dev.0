Return-Path: <oohall@gmail.com>
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429wpV5Vy2zF3S6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 21:07:14 +1000 (AEST)
Received: by mail-io1-xd41.google.com with SMTP id l7-v6so2775412iok.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 04:07:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d51126f75116534ec6ba6caee907b9db82363cc7.camel@kernel.crashing.org>
References: <153677132617.23091.12307288405707171077.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180912165846.GH118330@bhelgaas-glaptop.roam.corp.google.com>
 <d51126f75116534ec6ba6caee907b9db82363cc7.camel@kernel.crashing.org>
From: Oliver <oohall@gmail.com>
Date: Thu, 13 Sep 2018 21:07:12 +1000
Message-ID: <CAOSf1CH39usAocrtuBnZaPdMBorO9GHrABrEgokxTo-pySUVEg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add PPC contacts for PCI core error handling
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 Russell Currey <ruscur@russell.cc>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Oliver OHalloran <oliveroh@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 13, 2018 at 6:35 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2018-09-12 at 11:58 -0500, Bjorn Helgaas wrote:
>> > Add the generic PCI core error recovery files to the powerpc EEH
>> > MAINTAINERS entry so the powerpc folks will be copied on changes to the
>> > generic PCI error handling strategy.
>>
>> I really want to make sure the powerpc folks are plugged into any PCI core
>> error handling discussions.  Please let me know if there's a better way
>> than this patch, or if there are other people who should be added.
>
> Sounds good. Oliver, you want to be looped in as well ?

Sure, putting all of EEH on Sam is probably not a nice thing to do.

> Cheers,
> Ben.
>
>
