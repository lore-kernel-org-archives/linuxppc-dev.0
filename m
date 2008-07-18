Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id B1E4ADDFAB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Jul 2008 18:52:38 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KJlhb-0006ds-ML
	for linuxppc-embedded@ozlabs.org; Fri, 18 Jul 2008 01:52:35 -0700
Message-ID: <18525123.post@talk.nabble.com>
Date: Fri, 18 Jul 2008 01:52:35 -0700 (PDT)
From: Alex_SYS <schmid-grafenau@t-online.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Videomode 800x480
In-Reply-To: <m24p6o352u.fsf@ohwell.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <18470632.post@talk.nabble.com> <487CEC85.2070801@denx.de>
	<18482586.post@talk.nabble.com> <m24p6o352u.fsf@ohwell.denx.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hello, I`m on the embedded version, and have madee in qconf "framebuffer
console" with fbdev!
I`m sorry, but I don`t have the file "XModeMap" in my target! I have no X
Running!



Detlev Zundel wrote:
> 
> Hi Alex,
> 
>> Hello, the physical settings for sync are made by U-Boot and working!
>> But in Lunux when I use 800x480, the screen is well, but the Kernel
>> crashes
>> at Bootup!
>> Using 800x600 works!
>> Now I need only "Dummy" settings, that I can tell Linux I would like
>> 800x480
>> and the Kernel doesn`t crash!
>> I don`t know exactly why the Kernel crashes, I know only that the modedB
>> 800x600 and so on work!
>> I will try your settings immediately!
> 
> Your keymap seems to be broken.  Try to include this in your ~/.Xmodmap
> file:
> 
> keycode  10 = 1 period
> 
> Cheers
>   Detlev
> 
> -- 
> error compiling committee.c: too many arguments to function
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/Videomode-800x480-tp18470632p18525123.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
