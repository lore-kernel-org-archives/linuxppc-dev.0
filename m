Return-Path: <prasannatsmkumar@gmail.com>
Received: from mail-yw0-x242.google.com (mail-yw0-x242.google.com
 [IPv6:2607:f8b0:4002:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sKlKC40yzzDrHp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 23:25:03 +1000 (AEST)
Received: by mail-yw0-x242.google.com with SMTP id r9so2311664ywg.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 06:25:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160825121546.GA25650@Red>
References: <1472124856-12767-1-git-send-email-prasannatsmkumar@gmail.com>
 <20160825121546.GA25650@Red>
From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date: Thu, 25 Aug 2016 18:55:00 +0530
Message-ID: <CANc+2y4JqGRXCLUEpMo8EB8thW5jsweh0Lg2VjuvpNgSR-AwMA@mail.gmail.com>
Subject: Re: [PATCH] hwrng: pasemi_rng.c: Migrate to managed API
To: LABBE Corentin <clabbe.montjoie@gmail.com>
Cc: olof@lixom.net, mpm@selenic.com, Herbert Xu <herbert@gondor.apana.org.au>,
 linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> I will propose to use devm_ioremap_resource() instead for removing this hardcoded 0x100, but i cannot find any user of this driver in any dts. (And so cannot check that this 0x100 is given in any DT resource node)
>
> Is this normal ?

I wanted to use devm_ioremap_resource but could not find DT entry
required for this driver in any of the .dts files. So did not change
that. I could not find any dts/dtsi for this platform. So I assume
that the dtb is not present in the kernel, dtb is supplied by the
bootloader. I may be wrong in this. Can anyone confirm this?

Regards,
PrasannaKumar
