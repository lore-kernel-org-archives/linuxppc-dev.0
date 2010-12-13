Return-Path: <hs@denx.de>
Received: from b.relay.invitel.net (b.relay.invitel.net [62.77.203.4])
	by ozlabs.org (Postfix) with ESMTP id 784DEB6F14
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Dec 2010 21:13:13 +1100 (EST)
Date: Mon, 13 Dec 2010 11:12:56 +0100
From: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH 1/2] powerpc,
	mpc5200: update defconfig to fit with	2.6.37-rc4
In-reply-to: <20101213100647.GA5911@pengutronix.de>
To: Wolfram Sang <w.sang@pengutronix.de>
Message-id: <4D05F1A8.7030808@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-15
References: <1292047981-1435-1-git-send-email-hs@denx.de>
	<20101212084707.GA14580@pengutronix.de> <4D05C68F.4030600@denx.de>
	<20101213100647.GA5911@pengutronix.de>
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

Hello Wolfram,

Wolfram Sang wrote:
> Hi Heiko,
> 
>>>> -CONFIG_EEPROM_AT24=y
>>> NACK.
>> ... I did just the steps above mentioned, so this is
>> automagically done by "make mpc5200_defconfig" !
> 
> Yes, I understood that, but I can't help it: it is still wrong. I need
> it.

Ok, than we need to look why "make mpc5200_defconfig" did this ...
I try to look at this point.

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
