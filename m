Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 652D3DEAEE
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Apr 2008 06:01:17 +1000 (EST)
Message-ID: <47FFC397.9040200@freescale.com>
Date: Fri, 11 Apr 2008 15:01:27 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: =?UTF-8?B?QW5kcsOpIFNjaHdhcno=?= <Andre.Schwarz@matrix-vision.de>
Subject: Re: Flash on LocalBus @ MPC8343
References: <47FF802B.5020708@matrix-vision.de>
	<20080411153849.GB2588@loki.buserror.net>
	<47FFC2DE.80808@matrix-vision.de>
In-Reply-To: <47FFC2DE.80808@matrix-vision.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

André Schwarz wrote:
> Scott,
> 
> thanks for your help ... but
> 
> Scott Wood wrote:
>> On Fri, Apr 11, 2008 at 05:13:47PM +0200, Andre Schwarz wrote:
>>   
>>> To me it looks like there's a problem regarding the local bus in general.
>>>
>>> Am I missing a "compatible" or anything else ? "reg" or "ranges" ?
>>>     
>>
>> Do you have an of_bus_ids[] entry that covers the localbus?
>>
>>   
> what's this ?
> Where do I need to define this ? In dts or platform code ?

Platform code.

> 
> Can you give an example ?

mpc8313erdb.  simple-bus is listed as a compatible for the localbus in 
the dts, and it is listed of_bus_ids[] in the platform file.

-Scott
