Return-Path: <jjboor@aimsys.nl>
Received: from linserv001.aimsys.nl (a80-127-156-242.adsl.xs4all.nl
	[80.127.156.242])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6FD5C679EA
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Jun 2005 23:57:06 +1000 (EST)
In-Reply-To: <s2b0475d.030@scms1.sc.signaal.nl>
References: <s2b0475d.030@scms1.sc.signaal.nl>
Mime-Version: 1.0 (Apple Message framework v730)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <28079624-B644-4C06-A6D3-B4BBCEDDA4A2@aimsys.nl>
From: Jaap-Jan Boor <jjboor@aimsys.nl>
Date: Wed, 15 Jun 2005 15:56:54 +0200
To: Samuel Osorio Calvo <samuel.osorio@nl.thalesgroup.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: preemptive and low-latency patches for denx's 2.4.25
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have a patched 2.4.25 kernel with changes from the Denx kernel, the  
lck1 patchset (O(1) scheduler, preempt and lowlatency patches), linux  
trace toolkit patches (sort of handcrafted) and proprietary board  
specific patches.
It's probably incompatible with anything else. I can however make a  
patch against 2.4.25 vanilla for you.

Jaap-Jan


On 15-jun-2005, at 15:20, Samuel Osorio Calvo wrote:

> Hi all,
>
> Do any of you know where to find these patches for kernel 2.4.25  
> coming with ELDK's v.3.1.1?
> I've seen the RTAI patch for it but nothing about preemptive or low- 
> latency.. Will patches from "standard" distribution's kernels be  
> compatible?? If so, would  you, please, provide a link.....;-)
>
> Thanks a lot,
>
> Samuel.
>
> Unclassified.
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

____
J.G.J. Boor                       Anton Philipsweg 1
Software Engineer                 1223 KZ Hilversum
AimSys bv                         tel. +31 35 689 1941
Postbus 2194, 1200 CD Hilversum   jjboor at aimsys dot nl
