Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 2ED93DDF2B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Apr 2008 18:53:54 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1Jqlaw-000777-M7
	for linuxppc-embedded@ozlabs.org; Tue, 29 Apr 2008 01:53:50 -0700
Message-ID: <16955743.post@talk.nabble.com>
Date: Tue, 29 Apr 2008 01:53:50 -0700 (PDT)
From: wangyanlong <killyouatonce@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Virtex4FX12LC hangs in calibrating delay loop
In-Reply-To: <20070621151554.GA22663@cip.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <20070621151554.GA22663@cip.informatik.uni-erlangen.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I meet the same problem as yours ,  have you fix your problem now ??? I am
keep trying !!!!

Thomas Glanzmann wrote:
> 
> Hello,
> I used the HEAD secretlabs kernel and used ml403 defconfig. I still see
> no serial output from the _kernel_ on the serial console. But I do see
> output from the in kernel embedded boot loader "load_kernel". I typed in
> stop in xmd and got an instruction pointer which points to:
> 
>         c00045a0 <__delay>:
>         c00045a0:       2c 03 00 00     cmpwi   r3,0
>         c00045a4:       7c 69 03 a6     mtctr   r3
>         c00045a8:       4d 82 00 20     beqlr
>         c00045ac:       42 00 00 00     bdnz-   c00045ac <__delay+0xc>      
> <<<<<<<<
>         c00045b0:       4e 80 00 20     blr
> 
> So I guess it is the calibrating delay loop and I am not sure. I can
> reproduce
> this. It is always in this function. Now I wonder is my board missing
> timer interrupts? What could be the reason for this. And of course one
> much more important question:
> 
>         - Is the serial console initialized before or after the
>           calibrating delay loop?
> 
> Is there a way to get a backtrace out of this? If that is the case what
> do I have to do? Recompile the Kernel with frame pointers and attach
> gdb?
> 
>         Thomas
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/Virtex4FX12LC-hangs-in-calibrating-delay-loop-tp11235297p16955743.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
