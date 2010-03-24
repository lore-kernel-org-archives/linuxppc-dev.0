Return-Path: <hs@denx.de>
Received: from a.relay.invitel.net (a.relay.invitel.net [62.77.203.3])
	by ozlabs.org (Postfix) with ESMTP id 18B00B7D15
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Mar 2010 22:12:26 +1100 (EST)
Received: from mailgw2.invitel.net (mailgw2.invitel.net [91.82.208.35])
	by a.relay.invitel.net (Invitel Core SMTP Transmitter) with ESMTP id
	6F41011A261 for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Mar 2010 12:04:50 +0100 (CET)
Date: Wed, 24 Mar 2010 12:04:46 +0100
From: Heiko Schocher <hs@denx.de>
Subject: Re: Linuxppc-dev Digest, Vol 67, Issue 131
In-reply-to: <mailman.5997.1269426781.12538.linuxppc-dev@lists.ozlabs.org>
To: Daniel Ng <daniel.ng1234@gmail.com>
Message-id: <4BA9F1CE.4020608@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
References: <mailman.5997.1269426781.12538.linuxppc-dev@lists.ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Daniel,

> Date: Wed, 24 Mar 2010 13:33:48 +1100
> From: Daniel Ng <daniel.ng1234@gmail.com>
> To: linuxppc-dev@ozlabs.org
> Subject: SPI Driver for CPM2 8260 (8272 family)
> Message-ID:
> 	<547eba1b1003231933x738b2660u364b12d43bf980c@mail.gmail.com>
> Content-Type: text/plain; charset=ISO-8859-1
> 
> Hi,
> 
> Is there an SPI Driver in Linux for CPM2 8260-based processors?
> 
> I'm quite surprised that there doesn't seem to be one. Can someone
> please explain why this is?

Try to use drivers/spi/spi_mpc8xxx.c
It should work on CPM2 based processors.

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
