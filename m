Return-Path: <alohanono@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.159])
	by ozlabs.org (Postfix) with ESMTP id 2F126DDF5F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Feb 2008 03:33:26 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id 16so35691fgg.39
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Feb 2008 08:33:21 -0800 (PST)
Message-ID: <47B31BCD.9010203@gmail.com>
Date: Wed, 13 Feb 2008 17:33:17 +0100
From: "A. Nolson" <alohanono@gmail.com>
MIME-Version: 1.0
CC: linuxppc-embedded@ozlabs.org
Subject: Re: V4 FX12 and PLB TEMAC: no space for user logic?
References: <47B2B94A.6090600@dave-tech.it>
In-Reply-To: <47B2B94A.6090600@dave-tech.it>
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

Hi ,

I am now developing my own IPs and when I try to synthesize normally I 
get an error because the router finds no place to fit everything. I have 
resynthesized using the option:

XIL_PAR_ENABLE_LEGALIZER=1 ( loading the program with that variable on > 
XIL_PAR_ENABLE_LEGALIZER=1 xps). It took so much time because it uses a 
much more consuming algorithm but I managed to build it correctly.

Regards,
 
/A


llandre wrote:
> Hi Mohammad,
>
> I've just had a look at the messages you generously posted in the ml 
> about your experience with linux on V4 FX12 FPGA.
> I'd like to ask your opinion about FX12 practical usability in this 
> context (gigabit PLB TEMAC/linux).
> In this message
>
> http://article.gmane.org/gmane.linux.ports.ppc.embedded/16816
>
> you say the device is completely full. If I understand correctly your 
> system provides just the devices required to run the bandwidth test so 
> it seems there is no room for user logic (I think you did not even add 
> the memory controller required to access the NOR Flash containing 
> bootloader, kernel image and root fs that is clearly mandatory for 
> standalone product). Is that true? If it is, this limits a lot the 
> flexibility of this architecture in this configuration. What do you think?
>
>
>
> Regards,
> llandre
>
> DAVE Electronics System House - R&D Department
> web:   http://www.dave.eu
> email: r&d2@dave-tech.it
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>   
