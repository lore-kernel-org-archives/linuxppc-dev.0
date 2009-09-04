Return-Path: <xcarandiru@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D386FB7B60
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  5 Sep 2009 05:24:14 +1000 (EST)
Received: from mail-yw0-f190.google.com (mail-yw0-f190.google.com
	[209.85.211.190]) by ozlabs.org (Postfix) with ESMTP id 3DA48DDD01
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Sep 2009 05:24:13 +1000 (EST)
Received: by ywh28 with SMTP id 28so1683693ywh.15
	for <linuxppc-dev@ozlabs.org>; Fri, 04 Sep 2009 12:24:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d970ff420909041214o56cb58b3mfe71eb036218dada@mail.gmail.com>
References: <d970ff420909040604h1bb3874eg5c79f79f85e713a3@mail.gmail.com>
	<d970ff420909041201m343dafdfta0e55df8b5c01f60@mail.gmail.com>
	<d970ff420909041214o56cb58b3mfe71eb036218dada@mail.gmail.com>
Date: Fri, 4 Sep 2009 16:24:12 -0300
Message-ID: <d970ff420909041224xcc18a87p988b12ad8a7ccf47@mail.gmail.com>
Subject: Re: MPC85xx External/Internal Interrupts
From: Alemao <xcarandiru@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 4, 2009 at 4:14 PM, Alemao<xcarandiru@gmail.com> wrote:
> I've read some posts in the list, and about:
>
> irq_of_parse_and_map()
> irq_create_map()
>
> But Im still trying to understand MPC85xx TSEC1 dts.
>
> Gianfar driver is using request_irq(), and request_irq() uses virtual
> irq, right?
>
> Thats why in dts all irqs for TSEC1 are "offseted" of 16?
>
> Manual =A0| =A0DTS
> ---------------
> 13 =A0 =A0 =A0 =A0 29
> 14 =A0 =A0 =A0 =A0 30
> 18 =A0 =A0 =A0 =A0 34
>

This makes no sense.

CPM2-PIC, in MPC8555ERM, its on 30. In DTS is on 46. Offset of 16.
But my platform code use irq_of_parse_and_map()!

So why this offset?!?!

--
Alemao
