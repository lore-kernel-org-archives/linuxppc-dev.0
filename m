Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 46793DDF5B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Jul 2007 05:50:40 +1000 (EST)
In-Reply-To: <000801c7cf51$f98ebb90$9503a8c0@Ansari>
References: <000801c7cf51$f98ebb90$9503a8c0@Ansari>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <880B302A-742A-4CC1-BB41-E7BD1CE570C6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Reboot Command Makes kernel to hang (MPC8560)
Date: Thu, 26 Jul 2007 14:51:31 -0500
To: Ansari <ma.harounansari@gdatech.co.in>
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


On Jul 26, 2007, at 1:55 AM, Ansari wrote:

> Hi all,
>
> Processor (MPC8560)
>
> Whenever reboot command is given in the linux console. The  
> processor gets reset and it loads bootloader , kernel and when  
> uncompressing the ramdisk it gets hang. The sample log is given  
> below. Any u please tell me what are the factors that can makes  
> this to happen.

This is very board dependant.  The MPC8560 doesn't have a clean way  
to request reset, and odds are you're only getting the core reset and  
not the full chip.

- k
