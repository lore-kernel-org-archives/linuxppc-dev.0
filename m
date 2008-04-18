Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id E5BC6DEDEC
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 01:22:07 +1000 (EST)
Message-ID: <4808BC33.7070109@ru.mvista.com>
Date: Fri, 18 Apr 2008 19:20:19 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] PowerPC 44x: Add NOR flash entry to Canyonlands DTS.
References: <20080417193744.GA17524@ru.mvista.com>
	<200804181626.09585.sr@denx.de>
In-Reply-To: <200804181626.09585.sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stefan Roese wrote:
> On Thursday 17 April 2008, Valentine Barshak wrote:
>> This patch adds NOR flash entry to the PowerPC 460EX Canyonlands DTS.
> 
> Right, I forgot to add this. But the partition names and sizes are a little 
> different from those we used before (e.g. kilauea). I'll send a patch to 
> update the Canyonlands & Glacier dts files in a short while.
> 

I've got these partition names and sizes form amcc site.
They seem to correspond to u-boot environment my board has.
Are these incorrect?
Thanks,
Valentine.

> Thanks.
> 
> Best regards,
> Stefan
