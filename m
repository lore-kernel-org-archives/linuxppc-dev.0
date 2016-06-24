Return-Path: <robh+dt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rbqtN1jrfzDqlQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jun 2016 06:38:51 +1000 (AEST)
Received: from mail.kernel.org (localhost [127.0.0.1])
 by mail.kernel.org (Postfix) with ESMTP id 095A520211
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 20:38:49 +0000 (UTC)
Received: from mail-yw0-f180.google.com (mail-yw0-f180.google.com
 [209.85.161.180])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D92BE20204
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 20:38:47 +0000 (UTC)
Received: by mail-yw0-f180.google.com with SMTP id v77so110131424ywg.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 13:38:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CA+7wUsziB9P24bXnSrLB_t-KOZ2CVj9p5xZYsCnr5DNZL8mg+w@mail.gmail.com>
References: <5762E732.1030908@gmail.com>
 <CA+7wUsziB9P24bXnSrLB_t-KOZ2CVj9p5xZYsCnr5DNZL8mg+w@mail.gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 24 Jun 2016 15:38:27 -0500
Message-ID: <CAL_JsqK=h5EC4RR4xpn-JioAbdLfmQFNt8MJk=UF==WvDWy-wQ@mail.gmail.com>
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

On Fri, Jun 17, 2016 at 2:51 AM, Mathieu Malaterre
<mathieu.malaterre@gmail.com> wrote:
> v3 tested here multiple times ! memleak is now gone.
>
> Tested-by: Mathieu Malaterre <mathieu.malaterre@gmail.com>
>
> Thanks
>
> On Thu, Jun 16, 2016 at 7:51 PM, Frank Rowand <frowand.list@gmail.com> wrote:
>> From: Frank Rowand <frank.rowand@am.sony.com>
>>
>> Fix a memory leak resulting from memory allocation in safe_name().
>> This patch fixes all call sites of safe_name().

Applied, thanks.

Rob
