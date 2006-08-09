Return-Path: <urwithsudheer@gmail.com>
Received: from gdatech.co.in (mail.gdatech.co.in [202.144.30.226])
	by ozlabs.org (Postfix) with ESMTP id 01C8B679E9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Aug 2006 01:06:13 +1000 (EST)
Received: from [192.168.0.2] (localhost.localdomain [127.0.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 3987E8780B7
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Aug 2006 08:06:08 -0700 (PDT)
Received: from gdatech.co.in ([192.168.0.3])
	by [127.0.0.1] ([127.0.0.1]) (port 7027) (Abaca EPG outproxy filter
	1.3.4.5154-maint13 $Rev: 5154 $) id r689080608D-01-2
	for linuxppc-embedded@ozlabs.org; Wed, 09 Aug 2006 08:06:08 -0700
Received: from mail.gdatech.co.in (unknown [192.168.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id D40998780B2
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Aug 2006 08:06:07 -0700 (PDT)
Message-ID: <44D9F9DF.5020100@gmail.com>
Date: Wed, 09 Aug 2006 20:36:07 +0530
From: sudheer <urwithsudheer@gmail.com>
MIME-Version: 1.0
To: Ameet Patil <ammubhai@gmail.com>
Subject: Re: SystemAce Driver.
References: <20060724121452.55760.qmail@web53608.mail.yahoo.com>
	<44C4BE5B.3000002@gmail.com>
In-Reply-To: <44C4BE5B.3000002@gmail.com>
Content-Type: multipart/alternative;
	boundary="------------080003050104030504000705"
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

This is a multi-part message in MIME format.
--------------080003050104030504000705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello Ameet Patil

I am looking for linux kernel source 2.6.16 with system ace controller 
support. I downloaded the linux-2.6.16 and linux-2.6.17-1 source from 
kernel.org but could not find any files related to system ace 
controller  ( No xilinx_sysace directory in  drivers/block/) .  I have 
checked penguinppc.org also but could not get it.

Can you please send to me the link where i could download the 
linuxppc-2.6.16 source with system ace support.

Thanks & Regards
Sudheer

Ameet Patil wrote:
> Hi Raja,
>     I have ported the Xilinx System ACE driver to 2.6 kernel. Find the 
> latest one here:
> http://www.cs.york.ac.uk/rtslab/demos/amos/xupv2pro/patches/linuxppc-2.6.17.1-sysace-1.2.patch
>
> NOTE: this patch wouldn't work if you are using the TEMAC driver. In 
> which case use the -after-TEMAC patch found in the patches folder above.
>
> Check the following discussions (threads) for more details:
> 1. "Xilinx SystemACE driver for 2.6"
> 2. "Xilinx BSP for linux 2.6"
> 3. "Kernel hangs after "Now booting the kernel"."
>
> cheers,
> -Ameet
>
> Raja Chidambaram wrote:
>   
>>  Hi all,
>>  We are working on customized board with amcc 440SPe
>> processor & xilinx System Ace controller. The System
>> Ace controller is connected to compact flash driver.
>>
>> We use u-boot 1.2 as bootloader & linux kernel
>> 2.6.16-2.
>>
>> On the process the u-boot is able to detect compact
>> flash through Xilinx SystemAce controller & able to
>> load the kernel image into compact flash.But when the
>> linux boot's up it not able to detect the System Ace
>> controller or compact flash.
>>
>> Note:we need to have the root file system in compact
>> flash.
>>
>> Is their any drivers available for SystemAce
>> controller on linux 2.6,if their how to get it.please
>> help me in this
>>                                     with regards
>>                                      raja
>>
>>
>>
>> __________________________________________________
>> Do You Yahoo!?
>> Tired of spam?  Yahoo! Mail has the best spam protection around 
>> http://mail.yahoo.com 
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
>>     
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>   


--------------080003050104030504000705
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Hello Ameet Patil<br>
<br>
I am looking for linux kernel source 2.6.16 with system ace controller
support. I downloaded the linux-2.6.16 and linux-2.6.17-1 source from
kernel.org but could not find any files related to system ace
controller&nbsp; ( No xilinx_sysace directory in&nbsp; drivers/block/) .&nbsp; I have
checked penguinppc.org also but could not get it. <br>
<br>
Can you please send to me the link where i could download the
linuxppc-2.6.16 source with system ace support.<br>
<br>
Thanks &amp; Regards<br>
Sudheer<br>
<br>
Ameet Patil wrote:
<blockquote cite="mid44C4BE5B.3000002@gmail.com" type="cite">
  <pre wrap="">Hi Raja,
    I have ported the Xilinx System ACE driver to 2.6 kernel. Find the 
latest one here:
<a class="moz-txt-link-freetext" href="http://www.cs.york.ac.uk/rtslab/demos/amos/xupv2pro/patches/linuxppc-2.6.17.1-sysace-1.2.patch">http://www.cs.york.ac.uk/rtslab/demos/amos/xupv2pro/patches/linuxppc-2.6.17.1-sysace-1.2.patch</a>

NOTE: this patch wouldn't work if you are using the TEMAC driver. In 
which case use the -after-TEMAC patch found in the patches folder above.

Check the following discussions (threads) for more details:
1. "Xilinx SystemACE driver for 2.6"
2. "Xilinx BSP for linux 2.6"
3. "Kernel hangs after "Now booting the kernel"."

cheers,
-Ameet

Raja Chidambaram wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">
 Hi all,
 We are working on customized board with amcc 440SPe
processor &amp; xilinx System Ace controller. The System
Ace controller is connected to compact flash driver.

We use u-boot 1.2 as bootloader &amp; linux kernel
2.6.16-2.

On the process the u-boot is able to detect compact
flash through Xilinx SystemAce controller &amp; able to
load the kernel image into compact flash.But when the
linux boot's up it not able to detect the System Ace
controller or compact flash.

Note:we need to have the root file system in compact
flash.

Is their any drivers available for SystemAce
controller on linux 2.6,if their how to get it.please
help me in this
                                    with regards
                                     raja



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
<a class="moz-txt-link-freetext" href="http://mail.yahoo.com">http://mail.yahoo.com</a> 
_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a>

    </pre>
  </blockquote>
  <pre wrap=""><!---->_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a>

  </pre>
</blockquote>
<br>
</body>
</html>

--------------080003050104030504000705--
