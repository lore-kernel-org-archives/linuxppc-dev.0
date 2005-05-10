Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 5FD68679E6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 May 2005 21:12:30 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j4ABH8Uw027338
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 May 2005 14:17:09 +0300 (EEST)
Message-ID: <42809349.4000700@intracom.gr>
Date: Tue, 10 May 2005 13:56:09 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Ricardo Scop <scop@digitel.com.br>
References: <427F4D3B.6060403@intracom.gr>
	<200505091605.08630.scop@digitel.com.br>
In-Reply-To: <200505091605.08630.scop@digitel.com.br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH  02/04] Freescale Ethernet combined driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ricardo Scop wrote:
> Hi Pantelis,
> 
> On Monday 09 May 2005 08:44, Pantelis Antoniou wrote:
> 
>>Hi
>>
>>The following patch is a combined FCC/FEC ethernet driver
>>for the Freescale line of PowerQUICCs.
>>
>>FECs on 8xx and FCCs on 82xx are supported.
>>
>>This part of the patch contains the core driver.
>>
> 
> and, inside the patch:
> 
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
> 
> Does this mean that the code is designed to be backwards compatible to 2.4.x 
> kernel code? If so, I could give it a try and, maybe, even make sure that it 
> keeps such compatibility.
> 
> Best regards,
> 
Yes the code support 2.4 also.

You need a diffent way to fill in the platform data though...

Regards

Pantelis
