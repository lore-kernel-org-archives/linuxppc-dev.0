Return-Path: <felix@embedded-sol.com>
Received: from sh78.surpasshosting.com (sh78.surpasshosting.com [72.29.64.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 042E3B6F10
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Apr 2011 21:03:14 +1000 (EST)
Message-ID: <4DA2BE49.9000003@embedded-sol.com>
Date: Mon, 11 Apr 2011 11:39:37 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Kushwaha Prabhakar-B32579 <B32579@freescale.com>
Subject: Re: Problem with mini-PCI-E slot on P2020RDB
References: <4B27FEE3.80001@embedded-sol.com>	<0949C49693EF1A47A54B0F0113CDB4A607674F@zin33exm23.fsl.freescale.net>	<4B28A7C3.6040209@embedded-sol.com>	<0949C49693EF1A47A54B0F0113CDB4A6076776@zin33exm23.fsl.freescale.net>	<4B28CBC4.4010501@embedded-sol.com>	<0949C49693EF1A47A54B0F0113CDB4A6076791@zin33exm23.fsl.freescale.net>	<4B29DC2B.8090405@embedded-sol.com>	<0949C49693EF1A47A54B0F0113CDB4A60767E8@zin33exm23.fsl.freescale.net>	<4B29F23A.9070001@embedded-sol.com>	<0949C49693EF1A47A54B0F0113CDB4A60767F0@zin33exm23.fsl.freescale.net>	<EBE3ECA5-AC1B-4E1C-A0DA-89260D0F03F6@kernel.crashing.org>	<4B2A946E.4040907@embedded-sol.com>	<BANLkTimf8uwgew3YPcNxdNj+4XamPhbxbQ@mail.gmail.com>	<071A08F2C6A57E4E94D980ECA553F87416D42F@039-SN1MPN1-004.039d.mgd.msft.net>
	<BANLkTi=QHOPTiuu2uXr1AcCXrpL3AT4cUw@mail.gmail.com>
	<071A08F2C6A57E4E94D980ECA553F87416F971@039-SN1MPN1-004.039d.mgd.msft.net>
In-Reply-To: <071A08F2C6A57E4E94D980ECA553F87416F971@039-SN1MPN1-004.039d.mgd.msft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Mahajan Vivek-B08308 <B08308@freescale.com>,
	Aggrwal Poonam-B10812 <B10812@freescale.com>,
	Leon Woestenberg <leon.woestenberg@gmail.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Gupta Maneesh-B18878 <B18878@freescale.com>,
	Fabian Bertholm <fabeisageek@googlemail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Assuming I have all patches in place, will this problem be
resolved on earlier board revisions (before rev D) ?

Felix.

On 04/11/2011 12:06 PM, Kushwaha Prabhakar-B32579 wrote:
> Hi Fabe,
>
> Yes .. P1020/P1011 RDB has same issue as of P2020RDB.
>
> It was because of some missing patches at u-boot and Linux.
>
> U-boot patch : It is already present in open source. Please use latest code base
> Linux patch : I am in process of posting in open source. Please make mentioned changes of IDSEL.
>
> --Prabhakar
>
>> -----Original Message-----
>> From: Fabian Bertholm [mailto:fabeisageek@googlemail.com]
>> Sent: Monday, April 11, 2011 1:53 PM
>> To: Kushwaha Prabhakar-B32579
>> Cc: Leon Woestenberg; linuxppc-dev@ozlabs.org; Mahajan Vivek-B08308;
>> Felix Radensky; Aggrwal Poonam-B10812; Gupta Maneesh-B18878
>> Subject: Re: Problem with mini-PCI-E slot on P2020RDB
>>
>> Hello Kushwaha Prabhakar,
>>
>> Our impression is that there is the same issue on the P1020/P1011 RDB.
>> Can you confirm this?
>>
>> Best Regards,
>> Fabe
>>
>>
>> 2011/4/8 Kushwaha Prabhakar-B32579<B32579@freescale.com>:
>>>
>>>> -----Original Message-----
>>>> From: Leon Woestenberg [mailto:leon.woestenberg@gmail.com]
>>>> Sent: Thursday, April 07, 2011 10:50 PM
>>>> To: linuxppc-dev@ozlabs.org
>>>> Cc: Kumar Gala; Mahajan Vivek-B08308; Aggrwal Poonam-B10812; Felix
>>>> Radensky; Kushwaha Prabhakar-B32579
>>>> Subject: Re: Problem with mini-PCI-E slot on P2020RDB
>>>>
>>>> Hello,
>>>>
>>>> On Thu, Dec 17, 2009 at 9:28 PM, Felix Radensky
>>>> <felix@embedded-sol.com>
>>>> wrote:
>>>>> Kumar Gala wrote:
>>>>>> On Dec 17, 2009, at 2:59 AM, Mahajan Vivek-B08308 wrote:
>>>>>>>> Thanks a lot. If I understand you correctly, the only way I can
>>>>>>>> get ath9k driver to work on this board using legacy interrupts
>>>>>>>> is to wait for a hardware fix. Right ?
>>>>>>>>
>>>>>>> Correct
>>>>>> I'm confused.  What's the issue with IRQ0 on the P2020RDB?  Is it
>>>>>> used for another purpose?
>>>>> There's a problem with IRQ0 with respect to mini-PCI-E slot. I have
>>>>> Atheros wireless card plugged into it. ath9k wireless driver for
>>>>> this card uses legacy PCI-E interrupts, and I get "irq 16: nobody
>> cared"
>>>>> message when driver executes request_irq(). Vivek has come to a
>>>>> conclusion that the problem is related to incorrect IRQ0 routing
>>>>> for mini-PCI-E slot on P2020RDB.
>>>>>
>>>> I would like to understand this issue better, as I seem to be running
>>>> into something similar, and it puts my board design on hold.
>>>>
>>>> Can someone (from Freescale) explain what happens if a PCI Express
>>>> end point on the mini-PCIe slot raises a legacy interrupt, and where
>>>> this goes wrong?
>>>>
>>>>  From what document or source code file can I conclude that the PCIe
>>>> legacy interrupt is shared with IRQ0?
>>>>
>>>>
>>>> I found this:
>>>>
>>>> P1020E/P2020E RDB System Errata, Last Update: 2/15/2010:
>>>> Problem:IRQ0 held low
>>>> Fix: Add 4.7K pull-up (to 3.3.V) for RTC_INT_N.
>>>> See R420 in Rev D schematic.
>>>> Add 4.7K pull-up (to 3.3.V) for MCU_INT_N.
>>>> See R423 in Rev D schematic.
>>>>
>>>>
>>> Hello Leon,
>>>
>>>   Yes you are right, PCIe leagacy interrupt is shared with IRQ0. For
>> Atheros issue.
>>>   Can you please try followings, Meanwhile I will try to dig into it.
>>>
>>> http://old.nabble.com/Problem-with-mini-PCI-E-slot-on-P2020RDB-td26802
>>> 038.html
>>>
>>> Regarding sata_sil24, Please see my e-mail on Linux-ide for correct
>> IDSEL value.
>>> Please first try IDSEL value mentioned in email on Linux-ide. Then try
>> this URL..
>>> --Prabhakar
>>>
>>> _______________________________________________
>>> Linuxppc-dev mailing list
>>> Linuxppc-dev@lists.ozlabs.org
>>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>>
>
