Return-Path: <dalang@cs.ubc.ca>
Received: from badenpowell.cs.ubc.ca (badenpowell.cs.ubc.ca [142.103.6.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1349A2BF09
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Nov 2004 12:41:37 +1100 (EST)
Date: Fri, 19 Nov 2004 15:36:47 -0800 (PST)
From: Dustin Lang <dalang@cs.ubc.ca>
To: Isidoro Reyes de Zuloaga <isidoro@qassessorament.net>
In-Reply-To: <200411192231.49831.isidoro@qassessorament.net>
Message-ID: <Pine.LNX.4.60.0411191523260.2564@bigrock.cs.ubc.ca>
References: <200411192231.49831.isidoro@qassessorament.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: netgear MA111 v2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

Disclaimer: I'm not an expert here, just someone with a working 
wireless-USB device on linux-ppc.

>From a brief web search, it looks like the support for SiS162 is not 
great.  If a (good) driver doesn't exist, you're just out of luck, unless 
you want to try to find specs for the chipset and then write something 
yourself (or wait for someone else to do it).  If you can, take it back 
and buy a different adapter.  There are several USB wireless devices that 
work well.  Look on the web for someone reporting that a given device 
works, and make sure you get exactly the right revision.  I have a Linksys 
WUSB 11 (I forget which rev) and it works great.

Cheers,
dstn

> Hi!
> I just bought the wireless usb adapter of netgear. I bought this model because
> i read arround that i was working fine with linux. The problem now is that i
> bought the v2 model, with a sis chipset.
> Does anyone know how to fix this, or what to do.
> I downloaded the wlan-ng drivers, i compile them....
> Just wanna know some ideas.
> thanks in advance.
> isidoro
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
