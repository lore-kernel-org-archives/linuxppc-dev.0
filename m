Return-Path: <clark@esteem.com>
Received: from mail5.hsphere.cc (mail5.hsphere.cc [216.157.145.25])
	by ozlabs.org (Postfix) with SMTP id 908CB2BF09
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Nov 2004 12:05:30 +1100 (EST)
Message-ID: <4191694C.60305@esteem.com>
Date: Tue, 09 Nov 2004 17:05:16 -0800
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
References: <20041109195141.82111C1430@atlas.denx.de>
In-Reply-To: <20041109195141.82111C1430@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: How much easier makes owning a BDI2000 things?
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
> In message <4190FE1F.4080105@esteem.com> you wrote:
> 
>>	Its worth it weight in gold bringing up custom boards the first time 
>>and writing/debuging the boot rom. It allows you to change register 
> 
> 
> ... or when debugging the Linux kernel, device drivers and especially
> RTAI real-time modules (because you can really freeze the CPU  state,
> including timers etc.).
> 
> 
>>	We haven't used ours much for debugging once things were up and 
>>running(we have fallen back to using printk statements for debugging). 
>>Though it can be used for that and some core kernel developers do use 
>>it. (probably for debugging the printk code of the kernel  ;-)  )
> 
> 
> Seems you never had to deal with any time critical problems, then.
> 

	I have, however I used I/O bits and an Oscilliscope ;-)

> 
> Best regards,
> 
> Wolfgang Denk
> 
Best Regards

-- Conn Clark

*****************************************************************
Give a man a match and you heat him for a moment. Set him on fire
and you'll heat him for life.
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com

Stock Ticker Symbol				ELST
