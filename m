Return-Path: <olof@lixom.net>
Received: from mail-lf0-x235.google.com (mail-lf0-x235.google.com
 [IPv6:2a00:1450:4010:c07::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zF6yF2Ft7zF0Rm
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jan 2018 05:54:10 +1100 (AEDT)
Received: by mail-lf0-x235.google.com with SMTP id h137so9973408lfe.8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 07 Jan 2018 10:54:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <86eade29-a56d-2aab-050e-366f4d43ab2f@xenosoft.de>
References: <36E75811-C758-49B1-8E5C-3A2C44FD5DE9@xenosoft.de>
 <874lnzz5y3.fsf@concordia.ellerman.id.au>
 <86eade29-a56d-2aab-050e-366f4d43ab2f@xenosoft.de>
From: Olof Johansson <olof@lixom.net>
Date: Sun, 7 Jan 2018 10:54:04 -0800
Message-ID: <CAOesGMhGt6arTt9p9rxT8Qreaucae0i=fmQoqkBvUGJOxobhiQ@mail.gmail.com>
Subject: Re: Spectre+Meltdown
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
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

On Sun, Jan 7, 2018 at 5:04 AM, Christian Zigotzky
<chzigotzky@xenosoft.de> wrote:
> Hello Michael,
>
> Thanks for your reply. We are using P.A. Semi and Freescale CPUs.
>
> @Olof
> Do you have some infos for us?

I'm low on spare time to experiment and explore what might be exposed
or not, and I no longer have any proprietary microarchitecture
documentation of the core.

I suggest reaching out to your supplier of the silicon for commercial
support and information, or just going with what I'm sure will be
architecturally generic solutions to the problem when IBM has them
ready.


-Olof
