Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id 1CA88DDE2F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Oct 2007 00:54:13 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2981826wag
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Oct 2007 07:54:12 -0700 (PDT)
Message-ID: <fa686aa40710170754p54aa405au9b046f7039ecb9ac@mail.gmail.com>
Date: Wed, 17 Oct 2007 08:54:11 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: aauer1 <aauer1@gmx.at>
Subject: Re: Linux booting problem on Xilinx ppc
In-Reply-To: <13252272.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <12694083.post@talk.nabble.com>
	<fa686aa40709152009k2b27ffc9kfb3fd0848f6b16d@mail.gmail.com>
	<12696686.post@talk.nabble.com> <13219154.post@talk.nabble.com>
	<000901c81006$7303b490$bb3ca688@LGE.NET>
	<13239003.post@talk.nabble.com>
	<fa686aa40710161237t54688b71g9c7cf9acdac2b744@mail.gmail.com>
	<13252272.post@talk.nabble.com>
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

On 10/17/07, aauer1 <aauer1@gmx.at> wrote:
> I was able to look at the __log_buf variable with the JTAG cable. So, I
> recognized that the kernel doesn't halt after the "No booting the kernel"
> message. There are many output messages in the __log_buf variable until it
> stops at with a "Kernel panic" because the rootfs is not found (but this is
> the minor problem).
> Now, I know that the kernel boots but I don't get an output with my Xilinx
> UartLite module. Are there some kernel modules which must be activated??
> Btw. I have used the Linux-2.6-virtex kernel from
> http://git.secretlab.ca/git/ and another Kernel (2.6.23 from kernel.org) -
> both with the same result.

Post the output of __log_buf here please.

g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
