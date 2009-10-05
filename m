Return-Path: <hs@denx.de>
Received: from a.relay.invitel.net (a.relay.invitel.net [62.77.203.3])
	by ozlabs.org (Postfix) with ESMTP id 07C04B7B97
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Oct 2009 21:13:24 +1100 (EST)
Received: from mail.invitel.hu (mail.invitel.hu [213.163.59.4])
	by a.relay.invitel.net (Invitel Core SMTP Transmitter) with ESMTP id
	DCC9211A1E6
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Oct 2009 12:13:22 +0200 (CEST)
Received: from [192.168.1.6] ([82.131.205.183])
	by mail.invitel.hu (Invitel Messaging Server)
	with ESMTPA id <0KR100A50DQAXNA0@invitel.hu> for
	linuxppc-dev@ozlabs.org; Mon, 05 Oct 2009 12:13:22 +0200 (CEST)
Date: Mon, 05 Oct 2009 12:12:58 +0200
From: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH v2] mpc5200: support for the MAN mpc5200 based board	uc101
In-reply-to: <20091005095340.GA3890@pengutronix.de>
To: Wolfram Sang <w.sang@pengutronix.de>
Message-id: <4AC9C6AA.6060009@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-15
References: <4AADF93C.3030604@denx.de> <20090914080322.GA3164@pengutronix.de>
	<fa686aa40909140745u2cf1dba7q8ae2af53c87bd216@mail.gmail.com>
	<4AC9A463.1080903@denx.de> <20091005095340.GA3890@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org
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
> On Mon, Oct 05, 2009 at 09:46:43AM +0200, Heiko Schocher wrote:
> 
>> - serial Console on PSC1
>> - 64MB SDRAM
>> - MTD CFI Flash
>> - Ethernet FEC
>> - IDE support
>>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
[...]
> [...]
>> +		wdt {
>> +			compatible = "generic,gpio-wdt";
>> +			reg = <0x600 0x10>;
>> +			gpios = <&gpt0 0 0>;
>> +			period = <500>;	// WDT trigger period in msec
>> +		};
> 
> Is this an official binding? I also did an gpio-watchdog a while ago and there
> were some issues with the binding, IIRC. Would be nice if this has been solved
> meanwhile.

Oh, sorry, no. I remove it.

> Other than that, it looks okay to me.

Ok, thanks for reviewing, I resent soon an update

bye
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
