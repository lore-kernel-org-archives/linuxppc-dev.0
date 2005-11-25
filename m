Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 82D9B687C7
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 Nov 2005 02:51:28 +1100 (EST)
Message-ID: <438732FD.7090201@ru.mvista.com>
Date: Fri, 25 Nov 2005 18:51:25 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Alex Zeffertt <ajz@cambridgebroadband.com>
References: <20051125153126.0385ddef.ajz@cambridgebroadband.com>
In-Reply-To: <20051125153126.0385ddef.ajz@cambridgebroadband.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC8272ADS stability issues
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Alex Zeffertt wrote:
> Hi all,
> 
> I have a question that is a bit off topic here, but you seem the most
> knowledgable people to ask so please don't flame me... :)
> 
> I am using an MPC8272ADS development board.  I was wondering if
> anybody on this list experienced hardware reliability problems with
> this platform.
> 
> I am running ELDK 3.1.1.  I have seen the kernel hang several times,
> and a Oops a few times too.  The reason I suspect that this is a
> hardware problem is that these seem to happen at completely random
> times, and the Oopses, in random places.  It doesn't seem to make
> any difference whether I have any of my own modules loaded or not, and
> I've even seen these problems occur in the bootloader.
> 
> I'm hoping for an answer along the lines of "Ah, you must have the
> 'fail randomly' dip switch set!"
> 
Unfortunately, low stability occasionally follows this boards. I have the same symptoms, 
and it is relative to something wrong with memory.

The mtest utility run in U-Boot will follow to crash or hang sooner or later. Hence its 
either broken memory or some hidden setting (probably undocumented) that the bootloader 
forgot to tweak in the time of memory controller init.

That question has been forwarded to FS, but still no response from them in this regard.

All I can suggest is to replace the board if it crashes more frequently than 
debug/development could proceed.
> TIA,
> 
> Alex
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 


-- 
Sincerely,
Vitaly
