Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 1E4DADDE1E
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 17:44:02 +1100 (EST)
Message-ID: <47E0B802.9040003@denx.de>
Date: Wed, 19 Mar 2008 07:51:46 +0100
From: Heiko Schocher <hs@denx.de>
MIME-Version: 1.0
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH v2] 8xx: Add support for the MPC852 based board from
	keymile.
References: <47DA444E.9050507@denx.de>	<20080315102508.bc698a90.sfr@canb.auug.org.au>	<47DF6B82.4030404@denx.de>	<20080318183320.49c98183.sfr@canb.auug.org.au>	<47DF777E.2030103@denx.de>
	<20080318191918.6505ba41@kernel.crashing.org>
In-Reply-To: <20080318191918.6505ba41@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Vitaly,

Vitaly Bordug wrote:
> On Tue, 18 Mar 2008 09:04:14 +0100
> Heiko Schocher wrote:
[...]
>> OK. Another thought about this. Shouldnt this table go in the dts?
>> A device node like
>>
>> cpm_pin {
>> 	pins = <port pin flags>;
>> };
>>
>> would be nice, or?
>>
> This has been a disputable question some time ago, and decided (or it looks like decided) that devtree describes hardware, and not the way it is configured at the moment. Therefor, best way for pin stuff is considered, as Scott mentioned, to set up stuff inside the firmware.

OK, I dont want to start a new discusion about that, but I always thought
(maybe learned, not sure anymore ;-) Linux should be as much independent
as possible from the bootloader(=firmware). If the firmware doesnt make
things right Linux maybe hang ... :-(

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
