Return-Path: <ammubhai@gmail.com>
Received: from mailgw.cs.york.ac.uk (mailgw.cs.york.ac.uk [144.32.40.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A69B067B61
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Jul 2006 05:52:20 +1000 (EST)
Message-ID: <44A580F5.8050900@gmail.com>
Date: Fri, 30 Jun 2006 20:52:21 +0100
From: Ameet Patil <ammubhai@gmail.com>
MIME-Version: 1.0
To: Ming Liu <eemingliu@hotmail.com>
Subject: Re: Xilinx SystemACE driver for 2.6
References: <BAY110-F40223AFCCAA679FBC5A962B27D0@phx.gbl>
In-Reply-To: <BAY110-F40223AFCCAA679FBC5A962B27D0@phx.gbl>
Content-Type: text/plain; charset=GB2312
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

Here is PART I of the article:
http://www.linux.get2knowmore.com/2006/06/30/quick-guide-linux-26-on-xilinx-virtex-ii-pro-boards-part-i/

Let me know if you get messages at boot time after following the above...

PART II we be posted shortly!

-Ameet

Ming Liu wrote:
> Hello Ameet,
> 
>> Do you have a Xilinx ML403 board?
> 
> Yes, I have ML403 board. The reason why I rename the xparameters_ml300 
> as xparameters_ml403 is that EDK generates the driver for ML300(the 
> xparameter header file is xparameters_ml300).
> 
> 
>> Does your kernel boot (show messages) without the SystemACE driver? Try
>> that first. It should boot and panic at the point where it tries to find
>> the root fs. Once you have reached this stage, you can then include the
>> SysAce driver.
> 
> I did try that. There is also no information. At that time, I guessed 
> that it was because of the missing of SystemACE driver.Do you think is 
> that the problem of others, for example the kernel? Before I use 2.6 
> version, I have successfully booted a linux 2.4 from CF card.
>> > My linux version is 2.6.16-rc5.
>> I don't think there is any issue with your kernel version apart from the
>> fact that 2.6.16- series posed considerable problem for me when trying
>> to configure a serial shell. The serial driver is BUGGY. So I use
>> 2.6.17.1 (latest release).
> 
> I use this version only because I want to implement the Temac driver in 
> the link of 
> http://ozlabs.org/pipermail/linuxppc-embedded/2006-March/022365.html It 
> looks that the patches are specific for that version.
> 
>> Is it possible for you to send me this Temac patch?
> 
> http://ozlabs.org/pipermail/linuxppc-embedded/2006-March/022365.html
> 
>> I am in the process of publishing a detailed article/tutorial on
>> compiling 2.6 kernel for the Xilinx MLxxx boards. Will send you the link
>> shortly!
> 
> I am really waiting for that!
> 
> Regards
> Ming
>>
>> > Thanks a lot in advance.
>> >
>> > Regards
>> > Ming
>> >
>> > _________________________________________________________________
>> > 与联机的朋友进行交流，请使用 MSN Messenger:  
> http://messenger.msn.com/cn
>> >
>> > _______________________________________________
>> > Linuxppc-embedded mailing list
>> > Linuxppc-embedded@ozlabs.org
>> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> _________________________________________________________________
> 与联机的朋友进行交流，请使用 MSN Messenger:  http://messenger.msn.com/cn 
> 
