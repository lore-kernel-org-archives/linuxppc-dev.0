Return-Path: <hs@denx.de>
Received: from b.relay.invitel.net (b.relay.invitel.net [62.77.203.4])
	by ozlabs.org (Postfix) with ESMTP id B49B3B70CC
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  6 Dec 2010 17:37:10 +1100 (EST)
Date: Mon, 06 Dec 2010 07:29:23 +0100
From: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH 1/2] powerpc, 5200: add support for charon board
In-reply-to: <20101204211644.GC671@pengutronix.de>
To: Wolfram Sang <w.sang@pengutronix.de>
Message-id: <4CFC82C3.3090307@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-15
References: <1291450906-22445-1-git-send-email-hs@denx.de>
	<20101204211644.GC671@pengutronix.de>
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
> On Sat, Dec 04, 2010 at 09:21:46AM +0100, Heiko Schocher wrote:
>> - MPC5200
>> - serielle console on PSC 1
> 
> serial

Hups, thanks!

>> - 128MiB RAM
>> - 32MiB NOR Flash
>> - FEC Ethernet
>> - 2 I2C Busses
>> - FPGA on CS3 accessed through mtd-ram
>> - ATA
> 
> although I am not sure we need those details in the commit log

Okay, I can remove them.

>> Signed-off-by: Heiko Schocher <hs@denx.de>
>> ---
>> based against 2.6.37-rc4
>>
>> ./scripts/checkpatch.pl 0001-powerpc-5200-add-support-for-charon-board.patch
>> total: 0 errors, 0 warnings, 233 lines checked
>>
>> 0001-powerpc-5200-add-support-for-charon-board.patch has no obvious style problems and is ready for submission.
>>
>>  arch/powerpc/boot/dts/charon.dts             |  226 ++++++++++++++++++++++++++
>>  arch/powerpc/platforms/52xx/mpc5200_simple.c |    1 +
>>  2 files changed, 227 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/powerpc/boot/dts/charon.dts
>>
>> diff --git a/arch/powerpc/boot/dts/charon.dts b/arch/powerpc/boot/dts/charon.dts
>> new file mode 100644
>> index 0000000..768f0cc
>> --- /dev/null
>> +++ b/arch/powerpc/boot/dts/charon.dts
>> @@ -0,0 +1,226 @@
>> +/*
>> + * TQM5200 board Device Tree Source
> 
> Ooops ;) Your board name here, maybe "based on TQM"

Yep, thats right! I rename this to charon, thanks for detecting.

[...]
>> diff --git a/arch/powerpc/platforms/52xx/mpc5200_simple.c b/arch/powerpc/platforms/52xx/mpc5200_simple.c
>> index d45be5b..d2e0096 100644
>> --- a/arch/powerpc/platforms/52xx/mpc5200_simple.c
>> +++ b/arch/powerpc/platforms/52xx/mpc5200_simple.c
>> @@ -58,6 +58,7 @@ static char *board[] __initdata = {
>>  	"promess,motionpro",
>>  	"schindler,cm5200",
>>  	"tqc,tqm5200",
>> +	"anon,charon",
> 
> Those are sorted alphabetically

Change this!

Thanks for the review,
bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
