Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x229.google.com (mail-wm0-x229.google.com
 [IPv6:2a00:1450:400c:c09::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rvRDF5kpdzDqQf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 16:03:25 +1000 (AEST)
Received: by mail-wm0-x229.google.com with SMTP id r190so29316246wmr.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 23:03:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAL_JsqK=h5EC4RR4xpn-JioAbdLfmQFNt8MJk=UF==WvDWy-wQ@mail.gmail.com>
References: <5762E732.1030908@gmail.com>
 <CA+7wUsziB9P24bXnSrLB_t-KOZ2CVj9p5xZYsCnr5DNZL8mg+w@mail.gmail.com>
 <CAL_JsqK=h5EC4RR4xpn-JioAbdLfmQFNt8MJk=UF==WvDWy-wQ@mail.gmail.com>
From: Mathieu Malaterre <mathieu.malaterre@gmail.com>
Date: Wed, 20 Jul 2016 08:03:03 +0200
Message-ID: <CA+7wUsyXMPu05mz4Mi6ELF=PJGLp82DTMFOHTZmQ2OHX_TdjWw@mail.gmail.com>
Subject: Re: [PATCH v3] of: fix memory leak related to safe_name()
To: Rob Herring <robh+dt@kernel.org>
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

On Fri, Jun 24, 2016 at 10:38 PM, Rob Herring <robh+dt@kernel.org> wrote:
> On Fri, Jun 17, 2016 at 2:51 AM, Mathieu Malaterre
> <mathieu.malaterre@gmail.com> wrote:
>> v3 tested here multiple times ! memleak is now gone.
>>
>> Tested-by: Mathieu Malaterre <mathieu.malaterre@gmail.com>
>>
>> Thanks
>>
>> On Thu, Jun 16, 2016 at 7:51 PM, Frank Rowand <frowand.list@gmail.com> wrote:
>>> From: Frank Rowand <frank.rowand@am.sony.com>
>>>
>>> Fix a memory leak resulting from memory allocation in safe_name().
>>> This patch fixes all call sites of safe_name().
>
> Applied, thanks.
>
> Rob

Could this patch be considered for stable ?

Thx
-- 
Mathieu
