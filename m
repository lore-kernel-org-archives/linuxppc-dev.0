Return-Path: <dhlii@dlasys.net>
Received: from outbound-mail-19.bluehost.com (outbound-mail-19.bluehost.com
	[69.89.20.234]) by ozlabs.org (Postfix) with SMTP id A349EDDFEF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Mar 2008 13:50:10 +1100 (EST)
Message-ID: <47E9B9E4.8040607@dlasys.net>
Date: Tue, 25 Mar 2008 22:50:12 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Tehn Yit Chin <tehn.yit.chin@gmail.com>
Subject: Re: interrupt handlers PowerPC via GCC
References: <bf04f99c0803191706q7e3a43a3i50a1d479650a3f9d@mail.gmail.com>	<47E29C60.10300@freescale.com>
	<bf04f99c0803241603v3151865eic80b58a04bce43e2@mail.gmail.com>
In-Reply-To: <bf04f99c0803241603v3151865eic80b58a04bce43e2@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
Reply-To: dhlii@dlasys.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Tehn Yit Chin wrote:
> Hey Scott,
>
> Thanks for the reply, I shall investigate further.
>
> I wasn't talking about interrupt handlers in Linux as such, but using
> powerpc-eabi-gcc to write an ISR for the MPC5516. (I guess that could be
> off-topic on this mailing list, but I thought the folks on this mailing list
> would probably know the answer pretty easily). I was hoping that gcc would
> generate the prologue and epilogue code for me via the interrupt attributes.
    I know nothing about GCC's interrupt attributes,
    however, there is no problem writing ISR's  from scratch (no OS)
    for the ppc. There are several boot loaders, monitors etc. out there
with examples.
     There is even one inside the Linux Kernel source - though it i
probably far more complex than you need.

    Somewhere I have something for the ppc405 I can send you - but most
ppc's are similar.


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
