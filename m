Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc2-s21.bay0.hotmail.com (bay0-omc2-s21.bay0.hotmail.com
	[65.54.246.157]) by ozlabs.org (Postfix) with ESMTP id 7CF5067B52
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Jul 2006 03:24:22 +1000 (EST)
Message-ID: <BAY110-F40223AFCCAA679FBC5A962B27D0@phx.gbl>
In-Reply-To: <44A5576D.6070901@gmail.com>
From: "Ming Liu" <eemingliu@hotmail.com>
To: ammubhai@gmail.com
Subject: Re: Xilinx SystemACE driver for 2.6
Date: Fri, 30 Jun 2006 17:24:17 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
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

Hello Ameet,

>Do you have a Xilinx ML403 board?

Yes, I have ML403 board. The reason why I rename the xparameters_ml300 as 
xparameters_ml403 is that EDK generates the driver for ML300(the xparameter 
header file is xparameters_ml300).


>Does your kernel boot (show messages) without the SystemACE driver? Try
>that first. It should boot and panic at the point where it tries to find
>the root fs. Once you have reached this stage, you can then include the
>SysAce driver.

I did try that. There is also no information. At that time, I guessed that 
it was because of the missing of SystemACE driver.Do you think is that the 
problem of others, for example the kernel? Before I use 2.6 version, I have 
successfully booted a linux 2.4 from CF card. 

> > My linux version is 2.6.16-rc5.
>I don't think there is any issue with your kernel version apart from the
>fact that 2.6.16- series posed considerable problem for me when trying
>to configure a serial shell. The serial driver is BUGGY. So I use
>2.6.17.1 (latest release).

I use this version only because I want to implement the Temac driver in the 
link of 
http://ozlabs.org/pipermail/linuxppc-embedded/2006-March/022365.html It 
looks that the patches are specific for that version. 


>Is it possible for you to send me this Temac patch?

http://ozlabs.org/pipermail/linuxppc-embedded/2006-March/022365.html 


>I am in the process of publishing a detailed article/tutorial on
>compiling 2.6 kernel for the Xilinx MLxxx boards. Will send you the link
>shortly!

I am really waiting for that!

Regards
Ming
>
> > Thanks a lot in advance.
> >
> > Regards
> > Ming
> >
> > _________________________________________________________________
> > 与联机的朋友进行交流，请使用 MSN Messenger:  
http://messenger.msn.com/cn
> >
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded

_________________________________________________________________
与联机的朋友进行交流，请使用 MSN Messenger:  http://messenger.msn.com/cn  
