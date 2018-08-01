Return-Path: <olof@lixom.net>
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com
 [IPv6:2a00:1450:4864:20::141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gdkW2d0pzF1Cr
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2018 02:17:39 +1000 (AEST)
Received: by mail-lf1-x141.google.com with SMTP id n96-v6so13722919lfi.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Aug 2018 09:17:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <877elaf92a.fsf@concordia.ellerman.id.au>
References: <4c4cb2b4391.4d23d508@auth.smtp.1and1.co.uk>
 <8736vzhb6h.fsf@concordia.ellerman.id.au>
 <87zhy7fw7f.fsf@concordia.ellerman.id.au>
 <fde71219-5e0e-cc12-a31f-258ce547f471@xenosoft.de>
 <877elaf92a.fsf@concordia.ellerman.id.au>
From: Olof Johansson <olof@lixom.net>
Date: Wed, 1 Aug 2018 09:17:34 -0700
Message-ID: <CAOesGMig7yYay8dZsjsc7pmZsqmHTrGDZOukOqOkTzjEB3=z1Q@mail.gmail.com>
Subject: Re: [PATCH] powerpc/pasemi: Seach for PCI root bus by compatible
 property
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>,
 Darren Stevens <darren@stevens-zone.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 1, 2018 at 7:36 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Christian Zigotzky <chzigotzky@xenosoft.de> writes:
>
>> Just for info: I tested it on my Nemo board today and it works.
>
> Awesome thanks.
>
> That's probably sufficient to merge it, and if it breaks anything we can
> always revert it.

Should be fine, all known boards have the properties in question, and
I doubt anyone has anything but Nemo and Electra/Chitra boards out
there.

It's a virtual root bus, so all boards have it irrespective of what
PCIe is brought out.

(I should hook up my test system and get it into the CI cycle again,
maybe this fall).


Acked-by: Olof Johansson <olof@lixom.net>


-Olof
