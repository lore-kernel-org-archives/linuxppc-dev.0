Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-x231.google.com (mail-yk0-x231.google.com
 [IPv6:2607:f8b0:4002:c07::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 77BC81A0075
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2015 19:37:36 +1100 (AEDT)
Received: by ykdr82 with SMTP id r82so174968064ykd.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2015 00:37:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <565AF986.9060106@xenosoft.de>
References: <565AF986.9060106@xenosoft.de>
Date: Mon, 30 Nov 2015 11:37:33 +0300
Message-ID: <CAOJe8K1911vDjMe9m_1vY6DSGpOk0TmL96Qf1whuNFXxHJesGw@mail.gmail.com>
Subject: Re: [P.A. Semi] Does the ethernet interface work on your Electra,
 Chitra, Nemo, and Athena board?
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/29/15, Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
> Hi All,
>
> Does the ethernet interface on your Electra, Chitra, Nemo, and Athena
> board work with the release candidates of the kernel 4.4? Unfortunately
> the P.A. Semi ethernet doesn't work on our Nemo boards with the release
> candidates of the kernel 4.4. We have set the following entries in the
> kernel config:
>
> CONFIG_NET_VENDOR_PASEMI=y
> CONFIG_PASEMI_MAC=y
>
> Could you please test the P.A. Semi ethernet on your P.A. Semi boards?

It's not clear from your descriptions what is not working. Does the
driver probe function find  a device? Does the interface show up in
the kernel? Can it send/receive packets?

Also please CC netdev.

Thanks.

>
> Thanks in advance,
>
> Christian
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
