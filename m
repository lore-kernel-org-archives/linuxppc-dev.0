Return-Path: <joel.stan@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTx4f6y8pzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 14:13:06 +1100 (AEDT)
Received: from mail-yw0-x22b.google.com (mail-yw0-x22b.google.com
 [IPv6:2607:f8b0:4002:c05::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vTx4f2sN9z9s7K
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2017 14:13:06 +1100 (AEDT)
Received: by mail-yw0-x22b.google.com with SMTP id p77so4858120ywg.1
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Feb 2017 19:13:06 -0800 (PST)
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <1487903902.23576.253.camel@kernel.crashing.org>
References: <20170223225357.9572-1-benh@kernel.crashing.org>
 <20170223225357.9572-5-benh@kernel.crashing.org>
 <CACPK8XdU-HZOa7vtWU3Ns1nvQG=x10DccXKMKxh_8Eqjku_7Jw@mail.gmail.com>
 <1487903902.23576.253.camel@kernel.crashing.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 24 Feb 2017 13:42:43 +1030
Message-ID: <CACPK8XeAWxBta+=WhcNGGMxvEsb6CZH20840_BjxP451Ej-qLA@mail.gmail.com>
Subject: Re: [PATCH 05/12] drm/ast: Fix calculation of MCLK
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: dri-devel@lists.freedesktop.org, linuxppc-dev@ozlabs.org,
 airlied@redhat.com, "Y . C . Chen" <yc_chen@aspeedtech.com>, eich@suse.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 24, 2017 at 1:08 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2017-02-24 at 12:54 +1030, Joel Stanley wrote:
>> On Fri, Feb 24, 2017 at 9:23 AM, Benjamin Herrenschmidt
>> <benh@kernel.crashing.org> wrote:
>> > Some braces were missing causing an incorrect calculation.
>> >
>> > Y.C. Chen from Aspeed provided me with the right formula
>> > which I tested on AST2400 and 2500.
>>
>> Y. C. Chen, can you point out this calculation in the programming
>> guide?
>>
>> All of the PLL calculations I can find in the ast2400 documentation
>> are different to this one.
>
> Different PLL register, see my other email. I've checked the result
> of the calculation on our AST2500 and AST2400 machines.

I see now. It woudl be good to see the calculation added to Aspeed's
documentation in the future.

Acked-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel
