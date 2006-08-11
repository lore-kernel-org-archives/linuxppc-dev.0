Return-Path: <ammubhai@gmail.com>
Received: from mailgw.cs.york.ac.uk (mailgw.cs.york.ac.uk [144.32.40.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ED42E67B67
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Aug 2006 19:37:40 +1000 (EST)
Message-ID: <44DC4F34.1070308@gmail.com>
Date: Fri, 11 Aug 2006 10:34:44 +0100
From: Ameet Patil <ammubhai@gmail.com>
MIME-Version: 1.0
To: sudheer <urwithsudheer@gmail.com>
Subject: Re: SystemAce Driver.
References: <20060724121452.55760.qmail@web53608.mail.yahoo.com>	<44C4BE5B.3000002@gmail.com>
	<44D9F9DF.5020100@gmail.com>
In-Reply-To: <44D9F9DF.5020100@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Sudheer,
    Frank has already answered your questions. If you have any problems 
with the SysAce patch... do let me know. I have written a small tutorial 
here if it helps...

http://linux.get2knowmore.com


-Ameet

sudheer wrote:
> Hello Ameet Patil
> 
> I am looking for linux kernel source 2.6.16 with system ace controller 
> support. I downloaded the linux-2.6.16 and linux-2.6.17-1 source from 
> kernel.org but could not find any files related to system ace 
> controller  ( No xilinx_sysace directory in  drivers/block/) .  I have 
> checked penguinppc.org also but could not get it.
> 
> Can you please send to me the link where i could download the 
> linuxppc-2.6.16 source with system ace support.
> 
> Thanks & Regards
> Sudheer
> 
> Ameet Patil wrote:
>> Hi Raja,
>>     I have ported the Xilinx System ACE driver to 2.6 kernel. Find the 
>> latest one here:
>> http://www.cs.york.ac.uk/rtslab/demos/amos/xupv2pro/patches/linuxppc-2.6.17.1-sysace-1.2.patch
>>
>> NOTE: this patch wouldn't work if you are using the TEMAC driver. In 
>> which case use the -after-TEMAC patch found in the patches folder above.
>>
>> Check the following discussions (threads) for more details:
>> 1. "Xilinx SystemACE driver for 2.6"
>> 2. "Xilinx BSP for linux 2.6"
>> 3. "Kernel hangs after "Now booting the kernel"."
>>
>> cheers,
>> -Ameet
>>
>> Raja Chidambaram wrote:
>>   
>>>  Hi all,
>>>  We are working on customized board with amcc 440SPe
>>> processor & xilinx System Ace controller. The System
>>> Ace controller is connected to compact flash driver.
>>>
>>> We use u-boot 1.2 as bootloader & linux kernel
>>> 2.6.16-2.
>>>
>>> On the process the u-boot is able to detect compact
>>> flash through Xilinx SystemAce controller & able to
>>> load the kernel image into compact flash.But when the
>>> linux boot's up it not able to detect the System Ace
>>> controller or compact flash.
>>>
>>> Note:we need to have the root file system in compact
>>> flash.
>>>
>>> Is their any drivers available for SystemAce
>>> controller on linux 2.6,if their how to get it.please
>>> help me in this
>>>                                     with regards
>>>                                      raja
>>>
>>>
>>>
>>> __________________________________________________
>>> Do You Yahoo!?
>>> Tired of spam?  Yahoo! Mail has the best spam protection around 
>>> http://mail.yahoo.com 
>>> _______________________________________________
>>> Linuxppc-embedded mailing list
>>> Linuxppc-embedded@ozlabs.org
>>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>>
>>>     
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
>>   
> 
