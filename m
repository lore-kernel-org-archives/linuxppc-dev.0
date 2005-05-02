Return-Path: <frannk_m1@yahoo.com>
Received: from web32207.mail.mud.yahoo.com (web32207.mail.mud.yahoo.com
	[68.142.207.138]) by ozlabs.org (Postfix) with SMTP id 4BF1A67B3B
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 May 2005 00:18:54 +1000 (EST)
Message-ID: <20050502141853.44897.qmail@web32207.mail.mud.yahoo.com>
Date: Mon, 2 May 2005 07:18:52 -0700 (PDT)
From: Frank <frannk_m1@yahoo.com>
To: Peter Asemann <peter.asemann@web.de>, linuxppc-embedded@ozlabs.org
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: Linux 2.4.25 from ELDK 3.1 won't compile
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--- Peter Asemann <peter.asemann@web.de> wrote:
> I still didn't manage to compile a kernel. Though I unselected
> as much 
> features as I could, the compiler still isn't happy. Any
> ideas?
> 
> Peter Asemann
> 
> 
> make[1]: Entering directory 
>
`/opt/asemann/eldk/ppc_8xx/usr/src/linux-2.4.25/arch/ppc/kernel'
> 
> (...)
> 
> ppc_8xx-gcc -D__KERNEL__ 
> -I/opt/asemann/eldk/ppc_8xx/usr/src/linux-2.4.25/include -Wall
> 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
> -fno-common 
> -fomit-frame-pointer 
> -I/opt/asemann/eldk/ppc_8xx/usr/src/linux-2.4.25/arch/ppc
> -fsigned-char 
> -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple
> -mstring 
> -nostdinc -I
> /opt/asemann/eldk/usr/lib/gcc-lib/ppc-linux/3.3.3/include 
> -DKBUILD_BASENAME=m8xx_setup  -c -o m8xx_setup.o m8xx_setup.c
> m8xx_setup.c:64: error: `bd_t' undeclared here (not in a
> function)
> m8xx_setup.c: In function `m8xx_calibrate_decr':
> m8xx_setup.c:192: error: `bd_t' undeclared (first use in this
> function)
> m8xx_setup.c:192: error: (Each undeclared identifier is
> reported only once
> m8xx_setup.c:192: error: for each function it appears in.)
> m8xx_setup.c:192: error: `binfo' undeclared (first use in this
> function)
> m8xx_setup.c:192: error: parse error before ')' token
> m8xx_setup.c:196: error: `IMAP_ADDR' undeclared (first use in

You have to define IMAP_ADDR in your platform header file. Take
a look at arch/ppc/platforms/tqm8xx.h


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
