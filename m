Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 40E4CDDED5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Jan 2008 09:16:07 +1100 (EST)
Message-ID: <478FD3B7.2030105@freescale.com>
Date: Thu, 17 Jan 2008 16:16:23 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Matias Sundman <linux@sundmangroup.com>
Subject: Re: SCHED_FIFO & System()
References: <478EFD4C.9070706@sundmangroup.com>
In-Reply-To: <478EFD4C.9070706@sundmangroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Matias Sundman wrote:
> Hello,
> I have some strange behavior in one of my systems.
> 
> I have a real-time thread under SCHED_FIFO which is running every 10ms. 
> It is blocking on a semaphore and released by a timer interrupt every 10ms.
> Generally this works really well.
> 
> However, there is a module in the system that makes a / system() / call 
> from c-code ;
> 
>   system("run_my_script");
> 
> By calling and running a bash script. Independent of how the actual 
> script looks like the real time thread does not get scheduled under 80ms 
> -- the time it takes
> for the system() call to finish.

Are you running a preemptible kernel?

-Scott
