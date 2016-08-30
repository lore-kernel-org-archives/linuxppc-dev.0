Return-Path: <prasannatsmkumar@gmail.com>
Received: from mail-yb0-x229.google.com (mail-yb0-x229.google.com
 [IPv6:2607:f8b0:4002:c09::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sNfvl4L1nzDr5y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 17:16:35 +1000 (AEST)
Received: by mail-yb0-x229.google.com with SMTP id h3so3488882ybi.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 00:16:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <48b8455031e.651d5701@auth.smtp.1and1.co.uk>
References: <1472124856-12767-1-git-send-email-prasannatsmkumar@gmail.com>
 <20160825121546.GA25650@Red>
 <CANc+2y4JqGRXCLUEpMo8EB8thW5jsweh0Lg2VjuvpNgSR-AwMA@mail.gmail.com>
 <48b8455031e.651d5701@auth.smtp.1and1.co.uk>
From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date: Tue, 30 Aug 2016 12:46:32 +0530
Message-ID: <CANc+2y64+ECEh0GwQU4qQrEtsFjjbmaRJYt1t=J1Q3nT6TG6sA@mail.gmail.com>
Subject: Re: hwrng: pasemi_rng.c: Migrate to managed API
To: Darren Stevens <darren@stevens-zone.net>
Cc: LABBE Corentin <clabbe.montjoie@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, mpm@selenic.com,
 olof@lixom.net, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Darren,

>> I wanted to use devm_ioremap_resource but could not find DT entry
>> required for this driver in any of the .dts files. So did not change
>> that. I could not find any dts/dtsi for this platform. So I assume
>> that the dtb is not present in the kernel, dtb is supplied by the
>> bootloader. I may be wrong in this. Can anyone confirm this?
>
> On mine (Amigaone X1000) that is correct, we boot linux with a vmlinux file,
> and the bootloader (CFE) passes a fixed dtb. I think it is possible to dump
> the tree from inside CFE, if it would help I can invetigate?

I don't know if it is possible to get dts from dtb even if you manage
to extract devicetree blob from your system.

Labbe, Do you know anyway to get dts from dtb? Is this step really
required to remove 0x100 value for this patch given that the value was
present here for years? If extracting dtb and converting dtb to dts is
easy and not time consuming, I am in favour of finding a way to remove
hard coded value.
