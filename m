Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DBC5DDDDDB
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 02:41:04 +1000 (EST)
In-Reply-To: <464C800C.20400@freescale.com>
References: <20070517143846.GC29795@ld0162-tx32.am.freescale.net>
	<FB8DD3C1-A095-4ABB-9E74-7EC66A43D983@kernel.crashing.org>
	<464C800C.20400@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FFBD3A3A-ADBE-4DC8-A1A1-4163367244D5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/5] powerpc: Document device nodes for I2C devices.
Date: Thu, 17 May 2007 11:39:22 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 17, 2007, at 11:17 AM, Scott Wood wrote:

> Kumar Gala wrote:
>>> diff --git a/Documentation/powerpc/booting-without-of.txt b/  
>>> Documentation/powerpc/booting-without-of.txt
>>> index b49ce16..67026ad 100644
>>> --- a/Documentation/powerpc/booting-without-of.txt
>>> +++ b/Documentation/powerpc/booting-without-of.txt
>>> @@ -1257,6 +1257,8 @@ platforms are moved over to use the  
>>> flattened- device-tree model.
>>>
>>>     e) I2C
>>>
>>> +   e1) I2C Controller
>>> +
>>>     Required properties :
>>>
>>>      - device_type : Should be "i2c"
>>> @@ -1277,6 +1279,10 @@ platforms are moved over to use the   
>>> flattened-device-tree model.
>>>        a digital filter sampling rate register
>>>      - fsl5200-clocking : boolean; if defined, indicated that  
>>> this  device
>>>        uses the FSL 5200 clocking mechanism.
>>> +    - #address-cells : should exist and be 1 if I2C devices are   
>>> declared
>>> +      in the device tree.
>>> +    - #size-cells : should exist and be 0 if I2C devices are  
>>> declared
>>> +      in the device tree.
>> As I've stated before, we need a bus number as well so we can  
>> handle  things like I2C switches and muxes.
>
> Is this something we handle now?  If not, then it's really not  
> within the scope of this patchset.  If so, how am I breaking it?

We don't handle i2c devices in the dev tree today.  If you are going  
to propose a solution it should work for all cases that people are  
aware of even if linux doesn't support the functionality.

If only some subset of cases are handled what good is the device tree  
to a user?  They will just have to figure out if their usage is  
supported or not and if not find some other solution that works for  
them.

- k
