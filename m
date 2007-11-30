Return-Path: <glikely@secretlab.ca>
Received: from rn-out-0102.google.com (rn-out-0910.google.com [64.233.170.185])
	by ozlabs.org (Postfix) with ESMTP id 10A3BDDDF8
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Dec 2007 00:43:25 +1100 (EST)
Received: by rn-out-0102.google.com with SMTP id i50so2273295rne
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Nov 2007 05:43:24 -0800 (PST)
Message-ID: <fa686aa40711300543i47991fa6m9812231625205026@mail.gmail.com>
Date: Fri, 30 Nov 2007 06:43:24 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: fabien <fabien.fb@gmail.com>
Subject: Re: ppcboot and powerpc branch question
In-Reply-To: <f8f856500711300533t3bad1c1dxb4ff137534acbccb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <f8f856500711300533t3bad1c1dxb4ff137534acbccb@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 11/30/07, fabien <fabien.fb@gmail.com> wrote:
> hi all,
>
> After some problem with my custom board and kernel 2.6.19 about the
> init process, i've moved
> on 2.6.23 and that had fixed my problems. (related to this post :
> http://marc.info/?l=linuxppc-embedded&m=119609022221017&w=2)
> Apparently it was a problem with cpm_uart on SMC1.
> (http://lkml.org/lkml/2007/9/23/99)
> the patch have been integrated in 2.6.23. Now i use this kernel and
> busybox works.
> I want to migrated my board in powerpc branch instead of ppc (i plan
> to use xenomai but in 2.6.23
> there is only an adeos patch for piowerpc branch), but i see the use
> of a device tree
> instead of bd_t struct. I'm a bit disappointed because i also see that
> older u-boot (in my case
> ppcboot 1.1.5) aren't capable to pass dts to kernel.
> Is there a way to keep my old bootloader to boot a powerpc branch kernel ?

Yes, you can build a 'cuImage' in arch/powerpc which wraps the kernel
image with a device tree and copies the bd_t data into the tree before
booting.

Cheers,
g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
