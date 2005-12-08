Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 72EFB688BD
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Dec 2005 02:56:19 +1100 (EST)
Message-ID: <439857A1.6060706@ru.mvista.com>
Date: Thu, 08 Dec 2005 18:56:17 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
References: <438C8E8E.3030306@cpe.fr> <438D4A03.4060500@compulab.co.il>
	<E3409EA9-80FF-4CFF-BF39-F2DE3BA4A609@kernel.crashing.org>
In-Reply-To: <E3409EA9-80FF-4CFF-BF39-F2DE3BA4A609@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Nathael PAJANI <nathael.pajani@cpe.fr>, linuxppc-embedded@ozlabs.org
Subject: Re: USB on MPC8272
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On Nov 30, 2005, at 12:43 AM, Mike Rapoport wrote:
> 
>> Nathael PAJANI wrote:
>>
>>> Hi all!
>>>
>>>
>>> I have to support USB hcd for an Actis board based on a MPC8248 
>>> processor. I already have a 2.6.9 linux kernel running fine on it, 
>>> and actualy have to use it rather than a newer one.
>>> I'm actualy looking for existing or ongoing jobs.
>>
>> Dear Nathael,
>> As far as I understand there are several drivers for the MPC8272 usb 
>> host controller, and none of them is in
>> official kernel tree.
>> There's a driver in Metrowerks BSP for linux 2.6 for MPC8272 (the 
>> Freescale driver), an orignally mpc8xx driver by Brad Parker ported to 
>> linux 2.4 for MPC8272 by Pantelis Antoniou, there ought to be USB 
>> driver by ArabellaSW also.
>> My driver ("http://cpm2usb.sourceforge.net./") is a port of the Brad 
>> Parker's driver to linux 2.6 with some modifications.
> 
> And, ideally we would like to see one driver get into the linux source 
> tree that everyone is happy with.  I'm told by someone that the FSL 
> driver is suppose to have working host support "was tested/verified with 
> keyboard/mouse/diskdrives/network".
> 
We have that FS driver rework in progress, but even now it's quite hard to estimate the finish. The result will proceed upstream, anyway, but this is long-term I afraid.
> - kumar
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 


-- 
Sincerely, 
Vitaly
