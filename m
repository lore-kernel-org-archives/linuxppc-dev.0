Return-Path: <martyn.welch@ge.com>
Received: from exprod5og110.obsmtp.com (exprod5og110.obsmtp.com [64.18.0.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 05C52B6EFF
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  5 Jul 2010 18:51:43 +1000 (EST)
Message-ID: <4C319CEC.3030709@ge.com>
Date: Mon, 05 Jul 2010 09:50:52 +0100
From: Martyn Welch <martyn.welch@ge.com>
MIME-Version: 1.0
To: Zang Roy-R61911 <r61911@freescale.com>
Subject: Re: [PATCH] rtc: add support for DS3232 RTC
References: <1278312326-19022-1-git-send-email-tie-fei.zang@freescale.com>	<20100705092231.2780a1b8@hyperion.delvare>
	<46EA46969DA12B47932A34F1DA67A147041870@zch01exm23.fsl.freescale.net>
In-Reply-To: <46EA46969DA12B47932A34F1DA67A147041870@zch01exm23.fsl.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@lists.ozlabs.org,
	Hu Mingkai-B21284 <B21284@freescale.com>, linux-i2c@vger.kernel.org,
	Srinivasan Srikanth-R9AABP <R9AABP@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Zang Roy-R61911 wrote:
>  
>
>   
>> -----Original Message-----
>> From: Jean Delvare [mailto:khali@linux-fr.org] 
>> Sent: Monday, July 05, 2010 15:23 PM
>> To: Zang Roy-R61911
>> Cc: linux-i2c@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; 
>> Hu Mingkai-B21284; Srinivasan Srikanth-R9AABP
>> Subject: Re: [PATCH] rtc: add support for DS3232 RTC
>>
>> Hi Roy,
>>
>> On Mon,  5 Jul 2010 14:45:26 +0800, Roy Zang wrote:
>>     
>>> This patch adds the driver for RTC chip DS3232 via I2C bus
>>>
>>> Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
>>> Signed-off-by: Jingchang Lu <b22599@freescale.com>
>>> Signed-off-by: Srikanth Srinivasan 
>>>       
>> <srikanth.srinivasan@freescale.com>
>>     
>>> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
>>> ---
>>> Tested on MPC8536DS and P4080DS board
>>>
>>>  drivers/rtc/Kconfig      |   11 +
>>>  drivers/rtc/Makefile     |    1 +
>>>  drivers/rtc/rtc-ds3232.c |  466 
>>>       
>> ++++++++++++++++++++++++++++++++++++++++++++++
>>     
>>>  3 files changed, 478 insertions(+), 0 deletions(-)
>>>  create mode 100644 drivers/rtc/rtc-ds3232.c
>>>       
>> You're sending this patch to the wrong list. Please read MAINTAINERS
>> again.
>>     
> Does linux-i2c@vger.kernel.org is the correct mail list?
> The rtc device is on the i2c bus.
> Roy
>   
I think the RTC mailing list is probably a little more appropriate...

Martyn

-- 
Martyn Welch (Principal Software Engineer)   |   Registered in England and
GE Intelligent Platforms                     |   Wales (3828642) at 100
T +44(0)127322748                            |   Barbirolli Square, Manchester,
E martyn.welch@ge.com                        |   M2 3AB  VAT:GB 927559189
