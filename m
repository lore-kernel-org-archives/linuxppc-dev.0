Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id BC7B3DDDED
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Feb 2008 05:16:59 +1100 (EST)
Message-ID: <47AC9C99.2000603@pikatech.com>
Date: Fri, 08 Feb 2008 13:16:57 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH] Fix powerpc vdso clock_getres().
References: <20080207064750.GG6887@bakeyournoodle.com>
In-Reply-To: <20080207064750.GG6887@bakeyournoodle.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>,
	Thomas Gleixner <tglx@linutronix.de>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tony Breeds wrote:
> Since implementing highres timers on powerpc the clock_getres syscall
> has reported different resolutions due to the vdso using the a low res
> value.  In the patch d7f71674ad7c3c4467e48f6ab9e85516dae2720 
> ([POWERPC] Use a sensible default for clock_getres() in the VDSO), the
> powerpc vdso was updated to use the correct value.
>
> This fix doesn't work on older compilers.  Below is a fix for powerpc,
> that introduces a new (generic) #define MONOTONIC_RES_NSEC which is
> equal to the 64 value stored in KTIME_MONOTONIC_RES.
>   
Just a confirmation that this patch fixed my compile issue. And I was 
using gcc-4.0.0.

Thanks,
   Sean
