Return-Path: <xcarandiru@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CFE8CB6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  5 Sep 2009 05:14:56 +1000 (EST)
Received: from mail-yw0-f190.google.com (mail-yw0-f190.google.com
	[209.85.211.190]) by ozlabs.org (Postfix) with ESMTP id 37F69DDD01
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Sep 2009 05:14:55 +1000 (EST)
Received: by ywh28 with SMTP id 28so1673673ywh.15
	for <linuxppc-dev@ozlabs.org>; Fri, 04 Sep 2009 12:14:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d970ff420909041201m343dafdfta0e55df8b5c01f60@mail.gmail.com>
References: <d970ff420909040604h1bb3874eg5c79f79f85e713a3@mail.gmail.com>
	<d970ff420909041201m343dafdfta0e55df8b5c01f60@mail.gmail.com>
Date: Fri, 4 Sep 2009 16:14:54 -0300
Message-ID: <d970ff420909041214o56cb58b3mfe71eb036218dada@mail.gmail.com>
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

I've read some posts in the list, and about:

irq_of_parse_and_map()
irq_create_map()

But Im still trying to understand MPC85xx TSEC1 dts.

Gianfar driver is using request_irq(), and request_irq() uses virtual
irq, right?

Thats why in dts all irqs for TSEC1 are "offseted" of 16?

Manual  |  DTS
---------------
13         29
14         30
18         34

And about external IRQs, MPC8555RM doesnt have IDs for them, what
should I use to request IRQ0 using irq_create_map()??

In MPC83xx all interrupts have IDs, including IRQ0, IRQ1...
That make things much more clear.

Thanks in advance,

--
Alemao
