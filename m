Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by ozlabs.org (Postfix) with ESMTP id CC506DDDF4
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 18 Nov 2007 08:53:22 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so225292anc
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Nov 2007 13:53:20 -0800 (PST)
Message-ID: <fa686aa40711171353t2e8789a2vcf6f2a72afc4c1cd@mail.gmail.com>
Date: Sat, 17 Nov 2007 14:53:20 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: keng_629 <keng_629@126.com>
Subject: Re: multiprocessor
In-Reply-To: <200711171445384213369@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200711171445384213369@126.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 11/16/07, keng_629 <keng_629@126.com> wrote:
>
>
> i am trying to make a exam about Multiprocessor on the Xilinx Virtex-4 with
> two PowerPc hard core.
> please give me some advices about  bootloader and os.
> how can i start my work.

I'm sorry, but I really don't understand what you're asking about.
Both u-boot and Linux run on the ppc405 cores that the Virtex-4 uses.
However, there is no cache coherency between the cores so you would
need to run a separate Linux image on each one.  (SMP doesn't work)

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
