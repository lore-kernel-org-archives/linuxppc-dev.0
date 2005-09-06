Return-Path: <jjboor@aimsys.nl>
Received: from linserv001.aimsys.nl (a80-127-156-242.adsl.xs4all.nl
	[80.127.156.242])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 69167681C4
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Sep 2005 00:17:12 +1000 (EST)
Message-ID: <431DA0D5.508@aimsys.nl>
Date: Tue, 06 Sep 2005 15:59:49 +0200
From: Jaap-Jan Boor <jjboor@aimsys.nl>
MIME-Version: 1.0
To: Alex Zeffertt <ajz@cambridgebroadband.com>
References: <20050906133122.225a0922.ajz@cambridgebroadband.com>	<431D8F5B.9050803@ru.mvista.com>
	<20050906144845.1e603c72.ajz@cambridgebroadband.com>
In-Reply-To: <20050906144845.1e603c72.ajz@cambridgebroadband.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: PCI on MPC827x
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

We use it with 2.4.25. I think you should take a look at Wolfang Denx' 
2.4 kernel

Jaap-Jan

Alex Zeffertt wrote:

>On Tue, 06 Sep 2005 16:45:15 +0400
>Vitaly Bordug <vbordug@ru.mvista.com> wrote:
>
>  
>
>>Alex Zeffertt wrote:
>>    
>>
>>>Hi list,
>>>
>>>Does the linuxppc kernel support PCI on PowerQUICC II chips?  If so, in which patch/release was
>>>it added?
>>>
>>>      
>>>
>>The PCI bridge for 8272ADS has been added in 2.6.12-rc6. This stuff 
>>should work on PQ2FADS as well.
>>    
>>
> 
>Thanks Vitaly.  Unfortunately we're using linux-2.4.25.
>
>Has anybody backported the PCI bridge to 2.4?  If not, do you think it's a lot of work?
>
>Alex
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>  
>


-- 
J.G.J. Boor                       Anton Philipsweg 1
Software Engineer                 1223 KZ Hilversum
AimSys bv                         tel. +31 35 689 1941
Postbus 2194, 1200 CD Hilversum   mailto:jjboor@aimsys.nl
