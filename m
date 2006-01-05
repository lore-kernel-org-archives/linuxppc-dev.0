Return-Path: <akonovalov@ru.mvista.com>
Received: from localhost.localdomain (85-21-157-103.broadband.corbina.ru
	[85.21.157.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F35EC68962
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 Jan 2006 05:57:18 +1100 (EST)
Message-ID: <43BDB19F.1020302@ru.mvista.com>
Date: Fri, 06 Jan 2006 02:54:07 +0300
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: mcnernbm@notes.udayton.edu
References: <OF4583615F.8ED595CE-ON852570ED.00736A17-852570ED.00736A1D@notes.udayton.edu>
In-Reply-To: <OF4583615F.8ED595CE-ON852570ED.00736A17-852570ED.00736A1D@notes.udayton.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: io.h question
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Brett,

Is your program a kernel module?
asm/io.h is for kernel only (everything is inside #ifdef __KERNEL__ ... #endif)
Probably you build the module incorrectly so that __KERNEL__ is not defined.
If this is the case you may want to check the LDD book, chapter 2 "Building and
Running Modules".

Thanks,
Andrei

mcnernbm@notes.udayton.edu wrote:
> I finally noticed out_8 and in_8 and what not are located in the ppc 
> io.h file in the kernel development download.  But when I tried to do a 
> io.h with in my program I added #include <asm/io.h>  and it seems to 
> find it with not problems but it can not find the functions with in that 
> file.  Am i missing a define I need to set or something so I can see the 
> right files with in io.h I am compiling for a ppc405 on a xilinx virtex 
> 4 board.
> Thanks
> Brett
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
