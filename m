Return-Path: <Andre.Schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id CCF05DDEDF
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Apr 2008 18:58:49 +1000 (EST)
Message-ID: <480079CA.5040000@matrix-vision.de>
Date: Sat, 12 Apr 2008 10:58:50 +0200
From: =?UTF-8?B?QW5kcsOpIFNjaHdhcno=?= <Andre.Schwarz@matrix-vision.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Flash on LocalBus @ MPC8343
References: <47FF802B.5020708@matrix-vision.de>
	<20080411153849.GB2588@loki.buserror.net>
	<47FFC2DE.80808@matrix-vision.de> <47FFC397.9040200@freescale.com>
In-Reply-To: <47FFC397.9040200@freescale.com>
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

Scott,

thanks , but ... can't find "of_bus_ids[]" entry.
I'm obviously out of sync. My last git-pull from denx is 3 days old, now=20
- need to update on monday.

It seems hard for "normal" people to keep up these days !


Cheers,
Andr=C3=A9


Scott Wood wrote:
> Andr=C3=A9 Schwarz wrote:
>> Scott,
>>
>> thanks for your help ... but
>>
>> Scott Wood wrote:
>>> On Fri, Apr 11, 2008 at 05:13:47PM +0200, Andre Schwarz wrote:
>>> =20
>>>> To me it looks like there's a problem regarding the local bus in=20
>>>> general.
>>>>
>>>> Am I missing a "compatible" or anything else ? "reg" or "ranges" ?
>>>>    =20
>>>
>>> Do you have an of_bus_ids[] entry that covers the localbus?
>>>
>>>  =20
>> what's this ?
>> Where do I need to define this ? In dts or platform code ?
>
> Platform code.
>
>>
>> Can you give an example ?
>
> mpc8313erdb.  simple-bus is listed as a compatible for the localbus in=20
> the dts, and it is listed of_bus_ids[] in the platform file.
>
> -Scott


MATRIX VISION GmbH, Talstra=DFe 16, DE-71570 Oppenweiler  - Registergeric=
ht: Amtsgericht Stuttgart, HRB 271090
Gesch=E4ftsf=FChrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
