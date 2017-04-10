Return-Path: <robh+dt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w1rwJ67wszDq5j
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 23:42:40 +1000 (AEST)
Received: from mail.kernel.org (localhost [127.0.0.1])
 by mail.kernel.org (Postfix) with ESMTP id CC87C2034E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 13:42:37 +0000 (UTC)
Received: from mail-qk0-f177.google.com (mail-qk0-f177.google.com
 [209.85.220.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CC81420263
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 13:42:36 +0000 (UTC)
Received: by mail-qk0-f177.google.com with SMTP id h67so111784407qke.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 06:42:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170410154348.051e7a34@roar.ozlabs.ibm.com>
References: <20170405123706.6081-1-npiggin@gmail.com>
 <20170405123706.6081-3-npiggin@gmail.com>
 <CAL_JsqK4zbACwWVb-rsrvBb4hjBCexrqKRKrzSiZrZH5w=bKqQ@mail.gmail.com>
 <20170406003251.533e2845@roar.ozlabs.ibm.com>
 <CAL_JsqLEvjb8S-+-JEa4ALHeCWHiR1A_4ur9kd3pBRJaFYWVKw@mail.gmail.com>
 <1491425881.4166.90.camel@kernel.crashing.org>
 <20170406103829.67d462e1@roar.ozlabs.ibm.com>
 <CAL_JsqKuomE41grhAvjFxkFbS4A3-M_TK8gP8FU=HdDpQ3TTkg@mail.gmail.com>
 <20170410154348.051e7a34@roar.ozlabs.ibm.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 10 Apr 2017 08:42:15 -0500
Message-ID: <CAL_Jsq+46G4oEDrsFu57DqYMHJBX_cigArff-JYujFgb8M3S8w@mail.gmail.com>
Subject: Re: [PATCH 2/3] of/fdt: introduce of_scan_flat_dt_subnodes and
 of_get_flat_dt_phandle
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 10, 2017 at 12:43 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
> On Thu, 6 Apr 2017 09:09:41 -0500
> Rob Herring <robh+dt@kernel.org> wrote:
>
>> On Wed, Apr 5, 2017 at 7:38 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
>> > Given that it's quite a small addition to of/fdt code, hopefully
>> > that gives you a reasonable justification to accept it.
>> >
>> > If you prefer not to, that's okay, but I think we would have to carry
>> > it in arch/powerpc at least for a time, because of the schedule we're
>> > working to for POWER9 enablement. As a longer term item I agree with you
>> > and Ben, it would be worth considering unflattening earlier.
>>
>> As I mentioned, keeping it in arch/powerpc I like even less. So this is fine.
>
> Here is the patch with the change you suggested. Can I add your
> ack and send it via the powerpc tree with the change that uses
> these interfaces?

Acked-by: Rob Herring <robh@kernel.org>
