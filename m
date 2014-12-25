Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-f171.google.com (mail-yk0-f171.google.com
 [209.85.160.171])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0C1711A0C6E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Dec 2014 20:35:09 +1100 (AEDT)
Received: by mail-yk0-f171.google.com with SMTP id 142so4478485ykq.30
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Dec 2014 01:35:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CADxRZqxWL3wc1pJM3013utvW5=eNh_Z5pfU1+XiO2wOruOvk5Q@mail.gmail.com>
References: <CADxRZqxWL3wc1pJM3013utvW5=eNh_Z5pfU1+XiO2wOruOvk5Q@mail.gmail.com>
Date: Thu, 25 Dec 2014 13:35:06 +0400
Message-ID: <CAOJe8K1yqHSuNR-_uswvtOSmvzM9JsKUFEKHwyyzZnif4MGHaw@mail.gmail.com>
Subject: Re: unable to boot kernel on power6
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Anatoly Pugachev <matorola@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/25/14, Anatoly Pugachev <matorola@gmail.com> wrote:
> Hello!
>
> Can someone from powerpc kernel guys look at
> https://bugzilla.redhat.com/show_bug.cgi?id=1093163
>
> It can not load kernel on power6 JS22 (type 7998) blade, starting from 3.11
> kernel (but 3.9.x actually bootable).

Try to boot from cd /usb instead of trying to boot through the network

> Thanks.
>
> PS: not sure, is it worth investigating since it's power6 (old hardware).
>
