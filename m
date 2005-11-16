Return-Path: <flucifredi@acm.org>
Received: from mail23.sea5.speakeasy.net (mail23.sea5.speakeasy.net
	[69.17.117.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2B495687C8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Nov 2005 11:08:15 +1100 (EST)
From: Federico Lucifredi <flucifredi@acm.org>
To: srideep.devireddy@wipro.com
In-Reply-To: <6AD9F6A5F6E096408F0B703773355A0751AC41@CHN-SNR-MBX01.wipro.com>
References: <6AD9F6A5F6E096408F0B703773355A0751AC41@CHN-SNR-MBX01.wipro.com>
Content-Type: text/plain
Date: Tue, 15 Nov 2005 19:00:46 -0500
Message-Id: <1132099246.9583.45.camel@zago.boston.ximian.com>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Problem:-BDI(u-boot) programming on MPC 8272ADS
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Srideep,
 I have never used the BDI 2000 with the MPC8272, however, I can tell
you that configuring your emulator for your specific board, if the
manufacturer does not provide a *verified* configuration for it, is
something that takes some time and a few variables to tweak.

 Maybe you can expect to find a configuration ready made for some
Motorola prototype board like the ADS 8272, *but* it would be a mistake
to assume that that maps directly to your hardware in a workable manner.

 Bottom line, you need to know exactly what all of the emulator knobs
are, and, if this is new hardware, keep in mind that it [the new
hardware] could be malfunctioning. Do not assume the hardware is
operating as a reliable computer unless you have positive proof that is
the case - my personal experience is that I tried to make an emulator
work on hardware that someone above me kept insisting "had to be
working" - which was not the case.  I got plenty of frustration and
nothing to show for it - I should have defended the case that the
hardware was not working much harder than I did 8)

 Anyway.. I am digressing. How is your BDI 2000 behaving ? I was using
an "Embedded Toolsmiths" emulator, by the way.

 -f

On Wed, 2005-10-12 at 17:14 +0530, srideep.devireddy@wipro.com wrote:
> Hi ,
> 
>    I am srideep , we  have problem in programming flash on MPC 8272
> ADS file using BDI 2000 with  linux as host. As I am new to this  I
> need your help in this regard.
> 
>  
> 
> We have connected the BDI2000 to MPC8272ADS board. We are working on
> linux  & I have  attached configuration file for 8272 ADS board .
> 
>  BDI 2000 could recognize the processor type.
> 
>  But when we try to program the flash (with uboot binary image ) at
> location 0xff800000 on MPC 8272ADS evaluation board, it failed to
> program,
> 
> We tried to unlock and do the same but still left with the same error.
> 
> But when we tried to program in any other location it programmed but
> it doesnt boot .
> 
> Can you kindly send us the working configuration file.
> 
>  
> 
>  
> 
> Thanks & Regards
> 
> Srideep Reddy D
> 
> Software Engineer 
> 
> Telecom solutions 
> 
> Wipro Technologies
> 
> 91-44-30691952
> 
>  
> 
> 
> 
> 
> Confidentiality Notice 
> 
> The information contained in this electronic message and any
> attachments to this message are intended
> for the exclusive use of the addressee(s) and may contain confidential
> or privileged information. If
> you are not the intended recipient, please notify the sender at Wipro
> or Mailadmin@wipro.com immediately
> and destroy all copies of this message and any attachments.
> 
