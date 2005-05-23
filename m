Return-Path: <vag@paulidav.org>
Received: from pimout3-ext.prodigy.net (pimout3-ext.prodigy.net
	[207.115.63.102]) by ozlabs.org (Postfix) with ESMTP id 07387679E2
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 23 May 2005 23:56:14 +1000 (EST)
Message-ID: <4291DEAF.1080705@paulidav.org>
Date: Mon, 23 May 2005 06:46:23 -0700
From: "Vladimir A. Gurevich" <vag@paulidav.org>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
References: <20050523082816.774E4C1512@atlas.denx.de>
In-Reply-To: <20050523082816.774E4C1512@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Microcode patches for mpc8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Wolfgang,

Wolfgang Denk wrote:

>>since we are on this topic here: look like SMC relocation is explicitly not supported and I can't see the SPI driver as well (unless it reuses 8260 driver). 
>>    
>>
>In our CVS tree? See the old linux-2.4 tree. We don't see  many  uses of 8xx systems recently with ucode requirements.
>  
>
I am completely puzzled now.  It looks like your stable, but old 
linux-2.4 tree has a much better selection of 8xx drivers compared to 
the linuxppc_2_4_devel. Why is that? What do you recommend for a new 
MPC852T-based development? Can the drivers be dropped into the newer 
tree or more serious backporting effort is needed?

Thanks,
Vladimir
