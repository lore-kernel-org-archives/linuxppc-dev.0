Return-Path: <robh+dt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rx1ft0XTzzDqSx
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jul 2016 05:58:30 +1000 (AEST)
Received: from mail.kernel.org (localhost [127.0.0.1])
 by mail.kernel.org (Postfix) with ESMTP id B88E720591
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 19:58:27 +0000 (UTC)
Received: from mail-yw0-f179.google.com (mail-yw0-f179.google.com
 [209.85.161.179])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8722A20588
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 19:58:26 +0000 (UTC)
Received: by mail-yw0-f179.google.com with SMTP id u134so112272261ywg.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 12:58:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CA+7wUsyXMPu05mz4Mi6ELF=PJGLp82DTMFOHTZmQ2OHX_TdjWw@mail.gmail.com>
References: <5762E732.1030908@gmail.com>
 <CA+7wUsziB9P24bXnSrLB_t-KOZ2CVj9p5xZYsCnr5DNZL8mg+w@mail.gmail.com>
 <CAL_JsqK=h5EC4RR4xpn-JioAbdLfmQFNt8MJk=UF==WvDWy-wQ@mail.gmail.com>
 <CA+7wUsyXMPu05mz4Mi6ELF=PJGLp82DTMFOHTZmQ2OHX_TdjWw@mail.gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 22 Jul 2016 14:58:06 -0500
Message-ID: <CAL_JsqJaWky61QA0qdKozyriYpZiR2poY+U-7a9Latr7z_FoSA@mail.gmail.com>
Subject: Re: [PATCH v3] of: fix memory leak related to safe_name()
To: Mathieu Malaterre <mathieu.malaterre@gmail.com>
Cc: Frank Rowand <frowand.list@gmail.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 20, 2016 at 1:03 AM, Mathieu Malaterre
<mathieu.malaterre@gmail.com> wrote:
> On Fri, Jun 24, 2016 at 10:38 PM, Rob Herring <robh+dt@kernel.org> wrote:
>> On Fri, Jun 17, 2016 at 2:51 AM, Mathieu Malaterre
>> <mathieu.malaterre@gmail.com> wrote:
>>> v3 tested here multiple times ! memleak is now gone.
>>>
>>> Tested-by: Mathieu Malaterre <mathieu.malaterre@gmail.com>
>>>
>>> Thanks
>>>
>>> On Thu, Jun 16, 2016 at 7:51 PM, Frank Rowand <frowand.list@gmail.com> wrote:
>>>> From: Frank Rowand <frank.rowand@am.sony.com>
>>>>
>>>> Fix a memory leak resulting from memory allocation in safe_name().
>>>> This patch fixes all call sites of safe_name().
>>
>> Applied, thanks.
>>
>> Rob
>
> Could this patch be considered for stable ?

Yes, I tagged it for stable. I didn't send it for 4.7, so it won't go
in until after 4.8-rc1 though.

Rob
