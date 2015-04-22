Return-Path: <jogo@openwrt.org>
Received: from arrakis.dune.hu (arrakis.dune.hu [78.24.191.176])
 (using TLSv1.1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 69B041A03A0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 06:53:16 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
 by arrakis.dune.hu (Postfix) with ESMTP id DA88928AFB1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 22:52:12 +0200 (CEST)
Received: from mail-qk0-f173.google.com (mail-qk0-f173.google.com
 [209.85.220.173])
 by arrakis.dune.hu (Postfix) with ESMTPSA id 6EE39280143
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 22:52:11 +0200 (CEST)
Received: by qkhg7 with SMTP id g7so238440152qkh.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 13:53:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOiHx==hwBGsYwT6MFV-ur=wnnUmqw_GF7sN8KOwUho3fz5uew@mail.gmail.com>
References: <20150422141721.D3F8C1A242E@localhost.localdomain>
 <CAOiHx==hwBGsYwT6MFV-ur=wnnUmqw_GF7sN8KOwUho3fz5uew@mail.gmail.com>
From: Jonas Gorski <jogo@openwrt.org>
Date: Wed, 22 Apr 2015 22:52:48 +0200
Message-ID: <CAOiHx=km-tquvxPm41ONyJ7tqTMObcD5T6tK8RLHPpr+RvLPDA@mail.gmail.com>
Subject: Re: [PATCH v2] spi: fsl-spi: use of_iomap() to map parameter ram on
 CPM1
To: Christophe Leroy <christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-spi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 22, 2015 at 10:46 PM, Jonas Gorski <jogo@openwrt.org> wrote:
>> ---
>>  v2: Use devm_ioremap_resource() instead of_iomap()
>
> Your subject and commitlog still talk about using of_iomap(), you need
> to update them too.

Hmm I didn't see the V3. Ignore this comment (the other one still applies).

Regards
Jonas
