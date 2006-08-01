Return-Path: <ammubhai@gmail.com>
Message-ID: <44CF3929.2050906@gmail.com>
Date: Tue, 01 Aug 2006 12:21:13 +0100
From: Ameet Patil <ammubhai@gmail.com>
MIME-Version: 1.0
To: Benjamin Heyne <benjamin.heyne@uni-dortmund.de>
Subject: Re: XUPV2P, Kernel 2.6.17 boot problem
References: <20060801100220.26176938@bob.dt.e-technik.uni-dortmund.de>
In-Reply-To: <20060801100220.26176938@bob.dt.e-technik.uni-dortmund.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Try this if it helps!

http://www.linux.get2knowmore.com/

-Ameet

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
> Now, I am not really sure where to start searching for the bug
> (I just want to implement some drivers - not the kernel itself ;-).
> The zImage.elf file is about 2MB large. Did anyone encounter
> a similar error? Does anyone have some hints where to
> look at for debugging, or what might be wrong?
> 
> Thanks in advance
> Best regards
