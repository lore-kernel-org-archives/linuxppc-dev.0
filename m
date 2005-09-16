Return-Path: <rtafas@parks.com.br>
Received: from PKMAIL.parks.local (mail.parks.com.br [200.248.200.133])
	by ozlabs.org (Postfix) with ESMTP id 715B9682C5
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Sep 2005 04:34:14 +1000 (EST)
Message-ID: <432AE61E.9060801@parks.com.br>
Date: Fri, 16 Sep 2005 12:34:54 -0300
From: Ricardo Fialho Tafas Junior <rtafas@parks.com.br>
MIME-Version: 1.0
To: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
References: <023EF71CB65AA949A2C510353690C86B5BF2C0@rokonet-e.rokonet_tree.local>
In-Reply-To: <023EF71CB65AA949A2C510353690C86B5BF2C0@rokonet-e.rokonet_tree.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: OpenSSL 0.9.8 compile error!
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

it worked and compiled ok.

thanks

Ricard Fialho Tafas Jr
  R&D Engineer
  Parks S.A. Comunicações Digitais
  www.parks.com.br
  +55 51 4700523
  e-mail: rtafas@parks.com.br



Eli Brin wrote:
> Dear Ricardo,
> 
> You need to add no-asm (and probably no-hw).  Please look at the makefile
> and Configure.
> 
> This works on 0.9.7b, but I believe that's you problem.
> 
> Eli
> 
> 
> 
> -----Original Message-----
> From: Ricardo Fialho Tafas Junior [mailto:rtafas@parks.com.br]
> Sent: Friday, September 16, 2005 1:19 PM
> To: linux-ppc-embedded
> Subject: OpenSSL 0.9.8 compile error!
> 
> 
> Hello list,
> 
> I'm trying to crosscompile openSSL to PPC8xx. I've downloaded the latest 
> version and when I call "make" I get the following error:
> 
> ppc_8xx-gcc -I.. -I../.. -I../../include -DOPENSSL_THREADS -D_REENTRANT 
> -DDSO_DLFCN -DHAVE_DLFCN_H -DB_ENDIAN -DTERMIO -O3 -Wall -c  -o 
> linux_ppc32.o linux_ppc32.s
> linux_ppc32.s: Assembler messages:
> linux_ppc32.s:109: Error: Unknown pseudo-op:  `.machine'
> make[3]: *** [linux_ppc32.o] Error 1
> make[3]: Leaving directory `/home/rtafas/voip_devel/openssl-0.9.8/crypto/bn'
> make[2]: *** [subdirs] Error 1
> make[2]: Leaving directory `/home/rtafas/voip_devel/openssl-0.9.8/crypto'
> make[1]: *** [build_crypto] Error 1
> make[1]: Leaving directory `/home/rtafas/voip_devel/openssl-0.9.8'
> make: *** [top] Error 2
> 
> Before that:
> I make a "./Configure linux-ppc" and edited the makefile to cross 
> compile it and to force it to use ppc-8xx_gcc and ppc_8xx-ar.
> 
> Any idea to solve this?
> Any "how to" to compile Openssl in embedded enviroment?
> 
> Thanks,
> 
