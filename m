Return-Path: <gautam@eisodus.com>
Received: from smtp1.iitb.ac.in (smtp1.iitb.ac.in [202.68.145.249])
	by ozlabs.org (Postfix) with SMTP id D1D97679A6
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 May 2006 23:56:17 +1000 (EST)
Message-ID: <445B5A98.8020004@eisodus.com>
Date: Fri, 05 May 2006 19:30:56 +0530
From: Gautam Borad <gautam@eisodus.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: frequent sig 11 with malloc() on mpc8xx
References: <20060505094007.0F169353AD3@atlas.denx.de>
In-Reply-To: <20060505094007.0F169353AD3@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

>No, of course not. Please read the FAQ to understand why standard RAM
>tests will never detect this type of problem. 
>
>Best regards,
>
>Wolfgang Denk
>
>  
>
 Thanks for the reply.
We are aware that its a FAQ and we rechecked the SDRAM configuration, 
everything seems fine.
We disabled burst mode and tried but that didnt help. Now we want to 
disable cache and check.
Is the cache disabled from u-boot or linux? Where do we have to modify 
the code to disable
the cache  completely. Basically we want to run the linux without using 
cache.

regards,
gautam.
