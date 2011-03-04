Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A998DB70E5
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Mar 2011 09:41:53 +1100 (EST)
Subject: Re: [PATCH] Fix masking of interrupts for 52xx GPT IRQ.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Henk Stegeman <henk.stegeman@gmail.com>
In-Reply-To: <AANLkTi=Wq_uF14TXWQ3ooOpbkroJfM_DOWZXJfCWDHcX@mail.gmail.com>
References: <fa686aa41003181102i2a702c61h8ecfe05568c2a42e@mail.gmail.com>
	<1295054884-18540-1-git-send-email-henk.stegeman@gmail.com>
	<1297033514.14982.6.camel@pasglop>
	<AANLkTikfKnLG1pBQuWLOcvuu7Za2cB9McyR=Z=h0nBpd@mail.gmail.com>
	<AANLkTim8W6np1A1d=SKFNS5ze8FmrbUekoZaY8_a=46A@mail.gmail.com>
	<AANLkTi=Wq_uF14TXWQ3ooOpbkroJfM_DOWZXJfCWDHcX@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 05 Mar 2011 09:41:42 +1100
Message-ID: <1299278502.8833.916.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-03-04 at 23:40 +0100, Henk Stegeman wrote:
> What if the unmask/mask functions are dropped and only interrupt
> enable/disable functions are provided?

No, that's backward. enable/disable are handled by the core, leave them
there.

> I.e: rename the old unmask/mask functions to enable/disable and
> register them as enable/disable? I did try that, and it works too, no
> spurious IRQ's and no missing IRQ's.
> 

Ben.
