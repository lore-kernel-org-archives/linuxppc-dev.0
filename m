Return-Path: <felix@embedded-sol.com>
Received: from sh78.surpasshosting.com (sh78.surpasshosting.com [72.29.64.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1428FB6F17
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Apr 2011 14:53:25 +1000 (EST)
Message-ID: <4DA3DAF6.9090909@embedded-sol.com>
Date: Tue, 12 Apr 2011 07:54:14 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Aggrwal Poonam-B10812 <B10812@freescale.com>
Subject: Re: Problem with mini-PCI-E slot on P2020RDB
References: <071A08F2C6A57E4E94D980ECA553F87417069A@039-SN1MPN1-004.039d.mgd.msft.net>
	<45903308677306428B6EE7E6FF5A520410B713@039-SN1MPN1-004.039d.mgd.msft.net>
In-Reply-To: <45903308677306428B6EE7E6FF5A520410B713@039-SN1MPN1-004.039d.mgd.msft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Gupta Maneesh-B18878 <B18878@freescale.com>,
	Kushwaha Prabhakar-B32579 <B32579@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Poonam

On 04/12/2011 07:05 AM, Aggrwal Poonam-B10812 wrote:
> Hello Felix
>
> Please find some comments inline.
>
> Regards
> Poonam
>
>> -----Original Message-----
>> From: Kushwaha Prabhakar-B32579
>> Sent: Tuesday, April 12, 2011 9:26 AM
>> To: Aggrwal Poonam-B10812
>> Subject: FW: Problem with mini-PCI-E slot on P2020RDB
>>
>>
>>
>> -----Original Message-----
>> From: Felix Radensky [mailto:felix@embedded-sol.com]
>> Sent: Monday, April 11, 2011 7:16 PM
>> To: Kushwaha Prabhakar-B32579
>> Cc: Fabian Bertholm; Leon Woestenberg; linuxppc-dev@ozlabs.org; Mahajan
>> Vivek-B08308; Aggrwal Poonam-B10812; Gupta Maneesh-B18878
>> Subject: Re: Problem with mini-PCI-E slot on P2020RDB
>>
>> Hi Prabhakar,
>>
>> On 04/11/2011 02:09 PM, Kushwaha Prabhakar-B32579 wrote:
>>> Hi,
>>>
>>> Yes. It wil be applicable for all revisions.
>>>
>>> Regards,
>>> Prabhakar
>>>
>> I'm sure this is applicable to all revisions, but it doesn't necessarily
>> makes things work. The problem I've reported back in 2009 still exists on
>> P2020RDB revC, even if I use the latest u-boot and kernel and make device
>> tree changes that you've suggested.
>> I've attached the boot log.
> As such there is no hardware fix related to this issue between RevC to RevD. The solution was a software patch to resolve the issue related to IRQ0.

Are you sure ? Please take a look at Freescale document titled 
"P1020E/P2020E RDB System Errata".
There's errata CE10, IRQ0 held low. It is fixed in Rev D. Vivek 
Mahajan, who looked at the issue back
in 2009, estimated that problem can be related to missing pull-up on 
IRQ0. This is exactly what is
fixed in Rev D.

Felix.
