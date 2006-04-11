Return-Path: <reyems@telkomsa.net>
Received: from ctb-mesg7.saix.net (ctb-mesg7.saix.net [196.25.240.77])
	by ozlabs.org (Postfix) with ESMTP id 89C5B679F3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Apr 2006 01:15:28 +1000 (EST)
Message-ID: <003101c65d7a$c68fbd60$1100a8c0@stefanlaptop>
From: "Stefan Meyer" <reyems@telkomsa.net>
To: "Kumar Gala" <galak@kernel.crashing.org>
References: <002301c65d52$fd7c6fd0$1100a8c0@stefanlaptop>
	<2A229EEE-36CF-4E1D-B94C-D4EB6AB5F5B3@kernel.crashing.org>
Subject: Re: Linux kernel for MPC834X platform
Date: Tue, 11 Apr 2006 17:15:30 +0200
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=response
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

Hi Kumar
Thanks for the advice. I will rebuild for powerpc and report back.
B.t.w. what is the story behind the ppc and powerpc branches anyway ?

Regards
Stefan

----- Original Message ----- 
From: "Kumar Gala" <galak@kernel.crashing.org>
To: "Stefan Meyer" <reyems@telkomsa.net>
Cc: <linuxppc-embedded@ozlabs.org>
Sent: Tuesday, April 11, 2006 3:03 PM
Subject: Re: Linux kernel for MPC834X platform


> 
> On Apr 11, 2006, at 5:30 AM, Stefan Meyer wrote:
> 
>> Hi All
>> Pardon the intrusion if this is not the correct way to get the  
>> relevant information, but I am relatively new to kernel hacking.
>> Anyway here goes my question:
>> I am getting a Freescale MPC8343 based board up and running and  
>> have been using the BSP (with patched 2.6.11 kernel) release by  
>> Freescale with great success.
>> However when I tried to use the USB ISO transactions it seems to be  
>> non functional. I have connected a known good working codec (tested  
>> on my PC's usb) and tried to access it via the low level sound  
>> driver (/dev/dsp) but it only creates garbled noise.
>> In the meanwhile, I have noticed that the official kernel release  
>> 2.6.17 also start supporting the MPC834X platform and would rather  
>> like to persue that avenue to get my problems addressed (hopefully).
>> I have downloaded the latest 2.6.17 kernel and got it going  with  
>> the configuration for MPC834x_sys, with relation to booting and  
>> ethernet comms.
>> However there are clearly no provision in the USB driver for  
>> setting up the usb clocks and ports (which is of course MPC834x  
>> specific).
>> I have tried to hack it by inserting approriate code form the  
>> 2.6.11 freescale kernel but with very little success.
>> On inspection of the 2.6.11 kernel from Freescale I have also  
>> noticed that the USB core drivers were heavily modified around DMA  
>> buffer management, although the 2.6.17 had no such hacks in place.
>> My question simply relates to the status of the MPC834x  
>> implementation on the 2.6.17 kernel in so far that it is  
>> operational and being tested on hardware platforms. Could you  
>> please direct me to the persons(s) who have experience with this  
>> platform ?
> 
> The USB support for MPC834x only exists if you build it for  
> ARCH=powerpc.  There is a patch on the list archives for adding  
> support to ARCH=ppc.  I don't know if there is any issue with ISO  
> transactions in those version, but they been shown to work with USB  
> ethernet and USB HD devices.
> 
> - kumar
>
