Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8E8C5DDED9
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 02:25:04 +1000 (EST)
Message-ID: <464C800C.20400@freescale.com>
Date: Thu, 17 May 2007 11:17:16 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/5] powerpc: Document device nodes for I2C devices.
References: <20070517143846.GC29795@ld0162-tx32.am.freescale.net>
	<FB8DD3C1-A095-4ABB-9E74-7EC66A43D983@kernel.crashing.org>
In-Reply-To: <FB8DD3C1-A095-4ABB-9E74-7EC66A43D983@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
>> diff --git a/Documentation/powerpc/booting-without-of.txt b/ 
>> Documentation/powerpc/booting-without-of.txt
>> index b49ce16..67026ad 100644
>> --- a/Documentation/powerpc/booting-without-of.txt
>> +++ b/Documentation/powerpc/booting-without-of.txt
>> @@ -1257,6 +1257,8 @@ platforms are moved over to use the flattened- 
>> device-tree model.
>>
>>     e) I2C
>>
>> +   e1) I2C Controller
>> +
>>     Required properties :
>>
>>      - device_type : Should be "i2c"
>> @@ -1277,6 +1279,10 @@ platforms are moved over to use the  
>> flattened-device-tree model.
>>        a digital filter sampling rate register
>>      - fsl5200-clocking : boolean; if defined, indicated that this  
>> device
>>        uses the FSL 5200 clocking mechanism.
>> +    - #address-cells : should exist and be 1 if I2C devices are  
>> declared
>> +      in the device tree.
>> +    - #size-cells : should exist and be 0 if I2C devices are declared
>> +      in the device tree.
> 
> 
> As I've stated before, we need a bus number as well so we can handle  
> things like I2C switches and muxes.

Is this something we handle now?  If not, then it's really not within 
the scope of this patchset.  If so, how am I breaking it?

-Scott
