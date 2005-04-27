Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 4402C67A64
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Apr 2005 19:50:51 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j3R9tEWL016535
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Apr 2005 12:55:16 +0300 (EEST)
Message-ID: <426F5D1A.7050805@intracom.gr>
Date: Wed, 27 Apr 2005 12:36:26 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Pantelis Antoniou <panto@intracom.gr>
References: <426F4598.6080009@intracom.gr>
In-Reply-To: <426F4598.6080009@intracom.gr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: USB Host on 8271 (A cry for help)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Pantelis Antoniou wrote:
> Hi there
> 
> I'm trying to get USB host mode to work on 8271 and I'm
> stumped.
> 
> The major problem is that automatic SOF generation as mentioned
> in the manual appears to not work (or it's not clear how to
> enable it).
> 
> I'm trying to port the 8xx based driver, which works
> adequately after applying the microcode patch.
> 
> Sadly usb host mode on 82xx appears to suck even more.
> 
> If anyone has *any* code that works for host mode on 82xx please
> contact me.
> 
> Regards
> 
> Pantelis
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

Found it.

Now it works. RCCR[EIE] must be set.

But is this mentioned anywhere in the USB chapter of the manual?

NO! That would be too easy.

Regards

Pantelis.

PS. Please, would someone from freescale include this fine
point in the manual?

Thank you.
