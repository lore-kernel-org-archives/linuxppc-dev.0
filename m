Return-Path: <ivica@asist-traffic.com>
Received: from mta1.siol.net (pegasus.siol.net [193.189.160.40])
	by ozlabs.org (Postfix) with ESMTP id 924112BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Nov 2004 21:48:23 +1100 (EST)
Message-ID: <41A709E1.4050608@asist-traffic.com>
Date: Fri, 26 Nov 2004 11:48:01 +0100
From: ivica@asist-traffic.com
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
References: <20041125225810.A5B02C1430@atlas.denx.de>
In-Reply-To: <20041125225810.A5B02C1430@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200 toolchain test
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Wolfgang Denk wrote:

>Dear Ivica,
>
>in message <41A5F930.3080104@asist-traffic.com> you wrote:
>  
>
>>I have a MPC5200 based custom board with preloaded u-boot.
>>    
>>
>
>May I ask why you want to start from scratch? Is it  for  educational
>purposes?  Otherwise  you  could  just  use  existing and well-tested
>toolchains  like  our  ELDK   which   isavailable   for   free   (see
>http://www.denx.de/ELDK.html);  of course you can also use the ELDK's
>build environment to rebuild everything from scratch  if  you  really
>want  to  be  sure  that you can recompile everything without need to
>rely on any external resources.
>  
>
Educational reasons were my primary motives besides the independence 
factor. :-)
I used ELDK extensively on my other projects and I was very pleased with 
the kit.
I used this kit on TQM boards on my former job. Board that I use now is 
totally
custom made and I expect to have difficulties with it anyway. My motto 
was "If I
can't build/create the tools I'm going to work with I really shouldn't 
mess around
in the first place".
That said, I will always keep a backup solution ready (read ELDK) and 
try to thoroughly
understand everything I do. I wanted to build my system from the ground 
up but
I don't have the tools to do it (BDI2000, ...). My board was preloaded 
with u-boot.
Since this board is not yet truly industrial ready I will need to 
somehow stress it and test it.
I will have a certain budget to spend.What tools should I use? BDI2000? 
Any alternatives,
or is this simply superior tool for debugging purposes?

>>So far I managed to create GNU toolchain for it with crostool from
>>Dan Kegel. Everything was built without any problems. Of course,
>>I wanted to test this toolchain so I wanted to compile a simple
>>hello_world program load it into the memory of my MPC5200 board
>>and run it. So far I've failed. I admit. I don't know how to compile
>>a program to run without the OS. But I have some clues. I think it
>>    
>>
>
>There is some pretty extensive documentation in our DULG about how to
>use U-Boot and Linux in Embedded systems; have a look at
>http://www.denx.de/twiki/bin/view/DULG/Manual
>
>  
>
Yes I know of it. It doesn't describe though the process of compiling 
and linking standalone
applications to run without OS.

Regards,
Ivica
