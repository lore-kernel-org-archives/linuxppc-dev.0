Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id 21365DDF69
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Apr 2008 13:14:29 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so89852anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Apr 2008 20:14:27 -0700 (PDT)
Message-ID: <fa686aa40804172014qfda92bek5a292b1c34833f4c@mail.gmail.com>
Date: Thu, 17 Apr 2008 20:14:27 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: rodolfo <rodolfo@lesc.ufc.br>
Subject: Re: problems with 'XPAR_PLB_CLOCK_FREQ_HZ'.
In-Reply-To: <75c089d6de2ba74b5fdbf6a6fd91e468@lesc.ufc.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <75c089d6de2ba74b5fdbf6a6fd91e468@lesc.ufc.br>
Cc: Linuxppc embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Apr 17, 2008 at 12:15 PM, rodolfo <rodolfo@lesc.ufc.br> wrote:
> Hi, everybody,
>
>  my xparameters_ml300.h does not include 'XPAR_PLB_CLOCK_FREQ_HZ'.
>
>
>   CC      arch/ppc/boot/simple/embed_config.o
>  arch/ppc/boot/simple/embed_config.c: In function 'embed_config':
>  arch/ppc/boot/simple/embed_config.c:781: error: 'XPAR_PLB_CLOCK_FREQ_HZ'
>  undeclared (first use in this function)
>  arch/ppc/boot/simple/embed_config.c:781: error: (Each undeclared identifier
>  is reported only once
>  arch/ppc/boot/simple/embed_config.c:781: error: for each function it
>  appears in.)
>  make[2]: ** [arch/ppc/boot/simple/embed_config.o] Erro 1
>  make[1]: ** [simple] Erro 2
>  make: ** [zImage] Erro 2
>

You probably didn't select the "linux_26" OS target in software
platform settings before generating your xparameters_ml40x.h file.

>
>  Can I replace 'XPAR_PLB_CLOCK_FREQ_HZ' for XPAR_CORE_CLOCK_FREQ_HZ/3
>  knowing that my MHS file description is:

No; that one is different.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
