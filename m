Return-Path: <felix@embedded-sol.com>
Received: from sh78.surpasshosting.com (sh78.surpasshosting.com [72.29.64.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1D84DB6FEF
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Apr 2011 17:19:19 +1000 (EST)
Message-ID: <4DA7F1AC.5030908@embedded-sol.com>
Date: Fri, 15 Apr 2011 10:20:12 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Kushwaha Prabhakar-B32579 <B32579@freescale.com>
Subject: Re: Problem with mini-PCI-E slot on P2020RDB
References: <45903308677306428B6EE7E6FF5A520410D3E6@039-SN1MPN1-004.039d.mgd.msft.net>
	<071A08F2C6A57E4E94D980ECA553F87417BAF7@039-SN1MPN1-004.039d.mgd.msft.net>
In-Reply-To: <071A08F2C6A57E4E94D980ECA553F87417BAF7@039-SN1MPN1-004.039d.mgd.msft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "leon.woestenberg@gmail.com" <leon.woestenberg@gmail.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Aggrwal Poonam-B10812 <B10812@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Poonam,

Thanks for the confirmation.

Felix.

On 04/15/2011 09:27 AM, Kushwaha Prabhakar-B32579 wrote:
> Added Linxppc-dev
>
>> -----Original Message-----
>> From: Aggrwal Poonam-B10812
>> Sent: Friday, April 15, 2011 11:47 AM
>> To: Felix Radensky
>> Cc: Kushwaha Prabhakar-B32579; leon.woestenberg@gmail.com
>> Subject: FW: Problem with mini-PCI-E slot on P2020RDB
>>
>> Hello Felix
>>
>> We checked with the Board designer, we need the board fixes "mentioned in
>> Board errata doc" on the board for this issue. Sorry for the confusion.
>>
>> The fixes are not present on RevC, also on some RevDs this fix also may
>> be absent.
>>
>>
>> Please let us know in case of any issues.
>>
>> Regards
>> Poonam
>>
>>> -----Original Message-----
>>> From: Leon Woestenberg [mailto:leon.woestenberg@gmail.com]
>>> Sent: Wednesday, April 13, 2011 2:52 PM
>>> To: Felix Radensky
>>> Cc: Aggrwal Poonam-B10812; linuxppc-dev@ozlabs.org; Gupta
>>> Maneesh-B18878; Kushwaha Prabhakar-B32579
>>> Subject: Re: Problem with mini-PCI-E slot on P2020RDB
>>>
>>> Felix,
>>>
>>> On Tue, Apr 12, 2011 at 6:54 AM, Felix Radensky
>>> <felix@embedded-sol.com>
>>> wrote:
>>>> On 04/12/2011 07:05 AM, Aggrwal Poonam-B10812 wrote:
>>>>> As such there is no hardware fix related to this issue between RevC
>>>>> to RevD. The solution was a software patch to resolve the issue
>>>>> related to IRQ0.
>>>> Are you sure ? Please take a look at Freescale document titled
>>>> "P1020E/P2020E RDB System Errata".
>>>> There's errata CE10, IRQ0 held low. It is fixed in Rev D. Vivek
>>>> Mahajan, who looked at the issue back in 2009, estimated that
>>>> problem can be related to missing pull-up on IRQ0.
>>>> This is exactly what is
>>>> fixed in Rev D.
>>>>
>>> That's my understanding as well.
>>>
>>> Check if R420 and R423 are populated. These are the required pull-ups.
>>> On Rev D they are populated. You might be able to add them yourself.
>>>
>>> Even if you have an Rev A-C PCB, this fix can already be applied; it
>>> was on my board! (the bottom of the board mentions the schematic
>>> revision)
>>>
>>> The resistors have a silkscreen designator block called X, the
>>> resistors are situated to the left and bottom of the silkscreen X.
>>> IIRC, between the flash and Px020 part.
>>>
>>> On the left side of R420 (or R423) I measured the block wave from the
>>> RTC, which fires the 32kHz interrupt rate on IRQ0. This fixed by the
>>> u- boot patch.
>>>
>>> Regards,
>>>
>>> Leon.
>
