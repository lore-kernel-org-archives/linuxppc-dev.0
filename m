Return-Path: <rodolfo@lesc.ufc.br>
Received: from lesc0.lesc.ufc.br (unknown [200.17.37.126])
	by ozlabs.org (Postfix) with ESMTP id 0FA43DDE26
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Mar 2008 08:28:53 +1100 (EST)
MIME-Version: 1.0
Date: Fri, 29 Feb 2008 18:28:49 -0300
From: rodolfo <rodolfo@lesc.ufc.br>
To: Linuxppc embedded <linuxppc-embedded@ozlabs.org>,
	rodolfo@lesc.ufc.br
Subject: Kernel 2.6 configuration
In-Reply-To: <fa686aa40802251205t5c9e76a3yf314b325bfcdd342@mail.gmail.com>
References: <fa686aa40802251205t5c9e76a3yf314b325bfcdd342@mail.gmail.com>
Message-ID: <8927698bba61c82f32d5229c83b1b557@lesc.ufc.br>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

As Grant Likely said I downloaded the last release of linux kernel
(2.6.24). How can I configure the kernel for XUP v II P ? Which are the
minimal required configuration for a simple test? I just want to check if
the ppc405 is booting the kernel image.

Thanks !

On Mon, 25 Feb 2008 13:05:19 -0700, "Grant Likely"
<grant.likely@secretlab.ca> wrote:
> On Mon, Feb 25, 2008 at 12:05 PM, rodolfo <rodolfo@lesc.ufc.br> wrote:
>> Hey everybody,
>>
>>  I'm in trouble;
>>
>>  1) The EDK flow: I set the OS in the Software Plataform Settings to
>>  linux_2_6 version 1.00.a. after that, in OS and Library section I have
> to
>>  fill out the fields "memory size" , "connected_periphs" , "ramdisk
> size"
>>  ... ?  How would I do it ?
>>
>>  2) Do I place xparametera_ml300.h in
> /opt/ELDK/ppc_4xx/usr/src/linux-2.6.15
>>  ? if not where?
> 
> You should download a current release of the linux kernel.  Don't use
> the one that comes with ELDK.
> 
> in arch/ppc/platforms/4xx/xparameters/xparameters_ml403.h.  If you're
> using the ml403 reference design, it is already there.  If you're
> using a custom design then you'll need to replace it.
> 
> See here for hints:
> 
> http://wiki.secretlab.ca/index.php/Linux_on_Xilinx_Virtex
> 
>>  3) I downloaded "ppc-2006-01-11.iso" from denx (ELDK) website and I'm
>>  trying to follow their instructions for ppc 4xx plataform.
>>  [ website: http://www.denx.de/wiki/view/DULG/ELDK ]
> 
> This is an old release of ELDK.  You should probably move up to a more
> recent release.
> 
>>
>>  In /opt/ELDK/ppc_4xx/usr/src/u-boot-1.1.4/ I do:
>>
>>  "make distclen" and  "make ml300_config" are ok! After "make all" in 
> I've
>>  got an error:
>>
>>  a - ppc_longjmp.o
>>  a - ppc_setjmp.o
>>  a - stubs.o
>>  make[1]: *** No rules for processing the target `hello_world.srec',
> needed
>>  by `all'. Stop.       --> note: "TRANSLATION FROM PORTUGESE"
>>  make[1]: Exiting `/opt/ELDK/ppc_4xx/usr/src/u-boot-1.1.4/examples'
>>  make: ** [examples] Error 2
> 
> You're using an ancient copy of u-boot that breaks with certain
> versions of the 'make' program.  You should try using a recent release
> of u-boot.  Alternately, you can hack the u-boot makefile to not build
> the examples directory.
> 
> Cheers,
> g.
> 
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
