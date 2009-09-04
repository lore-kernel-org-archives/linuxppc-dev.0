Return-Path: <xcarandiru@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 802DBB708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Sep 2009 23:39:08 +1000 (EST)
Received: from mail-yx0-f187.google.com (mail-yx0-f187.google.com
	[209.85.210.187]) by ozlabs.org (Postfix) with ESMTP id D9F0CDDD0C
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Sep 2009 23:39:06 +1000 (EST)
Received: by yxe17 with SMTP id 17so2426444yxe.9
	for <linuxppc-dev@ozlabs.org>; Fri, 04 Sep 2009 06:39:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d970ff420909040604h1bb3874eg5c79f79f85e713a3@mail.gmail.com>
References: <d970ff420909040604h1bb3874eg5c79f79f85e713a3@mail.gmail.com>
Date: Fri, 4 Sep 2009 10:13:32 -0300
Message-ID: <d970ff420909040613l43e91ff3occ6025168ac20287@mail.gmail.com>
Subject: Fwd: MPC85xx External/Internal Interrupts
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

Hi all,

In all MPC85xx DTS files I have seen this interrupt configuration for
TSEC1:

interrupts = <29 2 30 2 34 2>;

29 - TSEC1 interrupt transmit
30 - TSEC1 interrupt receive
34 - TSEC1 interrupt error


But in MPC8555RM, chapter 10.1.5.2 the numbers are these:

13 - TSEC1 interrupt transmit
14 - TSEC1 interrupt receive
18 - TSEC1 interrupt error


Im a little bit confused about this internal interrupts, how can I get
this numbers? TSEC1 is working normally.


My real problem is that my driver is trying to request the external
interrupt IRQ0, and I dont know what number use in INTR_NUM:

request_irq(INTR_NUM, , , , )


Im using linux-2.6.26

Cheers,

--
Alemao
