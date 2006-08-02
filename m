Return-Path: <dhlii@dlasys.net>
Received: from sccrmhc12.comcast.net (sccrmhc12.comcast.net [204.127.200.82])
	by ozlabs.org (Postfix) with ESMTP id 298E267C9A
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Aug 2006 06:06:37 +1000 (EST)
Message-ID: <44D1021C.5080602@dlasys.net>
Date: Wed, 02 Aug 2006 15:50:52 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: XUPV2P, Kernel 2.6.17 boot problem
References: <20060801100220.26176938@bob.dt.e-technik.uni-dortmund.de>
In-Reply-To: <20060801100220.26176938@bob.dt.e-technik.uni-dortmund.de>
Content-Type: text/plain; charset=ISO-8859-1
Reply-To: dhlii@comcast.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Benjamin Heyne wrote:
> Dear all,
> I am currently trying to get the 2.6.17.1 Linux kernel
> running on the Xilinx Virtex. I have the 2.4 kernel up
> and running - No problems there...
>
> But when using the 2.6 kernel (have copied xparameters file,
> patched for using TEMAC driver) with the same hardware configuration
> the following happens:
>
>
> loaded at:     00400000 0061813C
> board data at: 00616124 0061613C
> relocated to:  00405148 00405160
> zimage at:     0040585D 00615F42
> avail ram:     00619000 20000000
>
> Linux/PPC load: console=ttyS0,9600.....
>
> Uncompressing Linux...inflate returned FFFFFFFB
> exit
>
>   
    Zlib was upgraded with 2.6.17. The updated Zlib is broken on ppc32.
I am pretty certain it is fixed in 2.6.18-rc3


> Now, I am not really sure where to start searching for the bug
> (I just want to implement some drivers - not the kernel itself ;-).
> The zImage.elf file is about 2MB large. Did anyone encounter
> a similar error? Does anyone have some hints where to
> look at for debugging, or what might be wrong?
>
> Thanks in advance
> Best regards
>   


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too
numerous to list.

"Any intelligent fool can make things bigger and more complex... It
takes a touch of genius - and a lot of courage to move in the opposite
direction."
Albert Einstein
