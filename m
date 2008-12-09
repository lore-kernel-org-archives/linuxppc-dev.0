Return-Path: <dhlii@dlasys.net>
Received: from outbound-mail-152.bluehost.com (outbound-mail-152.bluehost.com
	[67.222.39.32]) by ozlabs.org (Postfix) with SMTP id 538E1474C1
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Dec 2008 07:34:18 +1100 (EST)
Message-ID: <493ED4B6.7010605@dlasys.net>
Date: Tue, 09 Dec 2008 15:27:34 -0500
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: monstr@seznam.cz
Subject: Re: Is anyone using the C67x00 USB Host ?
References: <49394978.10905@dlasys.net> <493D2B22.4000601@seznam.cz>
In-Reply-To: <493D2B22.4000601@seznam.cz>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Reply-To: dhlii@dlasys.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Michal Simek wrote:
> Hi David,
>
> currently I am working on backport this driver to 2.6.20 to Microblaze but
> a lot of things are the same.
>
> From HW site. Interrupt goes outside of IP directly to interrupt controller.
> And you need to call platform_device_register with proper structure.
>
> Could you send your kernel log?
>   
    I can post a log, but:
       Interrupts are occuring, and being trapped.
    The following code in the driver just seems to always return
IRQ_NONE when called from an interrupt.
   
        int_status = c67x00_ll_hpi_status(c67x00);
        if (!int_status)
            return IRQ_NONE;

    However, if I add a timer that just polls the interrupt handler, I
have the driver working (on the first port) but slowly.





> Thanks,
> Michal
>
>
>
>   
>


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
