Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.15.139.206])
	by ozlabs.org (Postfix) with ESMTP id 4BF7FDDE49
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 06:19:03 +1100 (EST)
Message-ID: <4730BE1A.8060502@semihalf.com>
Date: Tue, 06 Nov 2007 20:18:50 +0100
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2 08/12] [POWERPC] CM5200 DTS
References: <20071103235210.31906.83423.stgit@hekate.izotz.org>
	<20071103235259.31906.54116.stgit@hekate.izotz.org>
	<20071105005007.GH19867@localhost.localdomain>
In-Reply-To: <20071105005007.GH19867@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-2
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Sun, Nov 04, 2007 at 12:52:59AM +0100, Marian Balakowicz wrote:
>> Add device tree source file for CM5200 board.
> [snip]
>> +		rtc@800 {	// Real time clock
>> +			compatible = "mpc5200b-rtc","mpc5200-rtc";
>> +			device_type = "rtc";
> 
> No device_type here.
> 
> [snip]
>> +		spi@f00 {
>> +			device_type = "spi";
> 
> Definitely no device_type here.
> 
>> +			compatible = "mpc5200b-spi","mpc5200-spi";
>> +			reg = <f00 20>;
>> +			interrupts = <2 d 0 2 e 0>;
>> +			interrupt-parent = <&mpc5200_pic>;
>> +		};
> 
> [snip]
>> +		i2c@3d40 {
>> +			device_type = "i2c";
> 
> No device_type here.

OK, device_type removed for the above devices.

Thanks
m.
