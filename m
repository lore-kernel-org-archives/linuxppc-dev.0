Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 0CACF67B56
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Apr 2005 21:29:07 +1000 (EST)
Message-ID: <425D027F.1030707@ru.mvista.com>
Date: Wed, 13 Apr 2005 15:29:03 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <797470E884C6D611B7A500B0D0AA56D0F195AE@batistuta.spider.com>
In-Reply-To: <797470E884C6D611B7A500B0D0AA56D0F195AE@batistuta.spider.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: cpm_uart console problems?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Tsang, Chi Kit wrote:

>Hi,
>
>I am working on an 8260 based board and currently cannot get 
>the serial (running on SMC 1) to work using the 2.6.11 kernel. 
>The last message I see in my console is: "Now booting the 
>kernel".
>
>
>
>I currently do not specify the "console=ttyCPM" in my boot command 
>line. Would this be an issue?
>
>  
>
Well, I think so. I don't have 8260 but with similar cpm2 board with
"console=ttyCPM0,115200 " parameter serial console works fine.

>I have tried to add "console=ttyCPM" to my boot command line but in 
>such cases, the kernel would fail to boot. Using some LEDs as debug, 
>I tracked down the hang which seems to happen during cpm_uart_console_write.
>This is as far as I got.
>
>  
>
Because there is no such console device...

>I am running with devfs enabled in the kernel. Does the cpm_uart 
>driver work with devfs?
>
>  
>
Yes, but not very good actually, as far as devfs seems to be
deprecated.  At least on my 8272ADS.

>As an aside, I have ported the 2.6.5 kernel to my 8260 based board and
>both ethernet (FCC 1) and serial (SMC 1) worked okay using this particular
>kernel.
>
>Any suggestions/ideas would be much appreciated.
>
>Thanks,
>Chi
>
>  
>


-- 
Sincerely,
Vitaly
