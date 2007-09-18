Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by ozlabs.org (Postfix) with ESMTP id 14638DDE45
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Sep 2007 07:02:31 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2653269wag
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Sep 2007 14:02:30 -0700 (PDT)
Message-ID: <fa686aa40709181402s633b6946k685a0bffe8bb7c10@mail.gmail.com>
Date: Tue, 18 Sep 2007 15:02:28 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Robert Woodworth" <rwoodworth@securics.com>
Subject: Re: Xilinx FX60
In-Reply-To: <1190149090.7268.29.camel@PisteOff>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1190149090.7268.29.camel@PisteOff>
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

On 9/18/07, Robert Woodworth <rwoodworth@securics.com> wrote:
> I'm back trying to get the kernel on my Xilinx FX60 without success.
> Now I have more information:
>
> Using the Xilinx GDB, I'm getting either a "Bad Page fault exception" or
> a kernel "oops"
>
> The text in the _log_buf is as follows:
> (this happens before serial console init)
>
> Data machine check in kernel mode..
> Oops: machine check, sig: 7 [#1].
> <register dump>
>
>
>
> Any Ideas what would cause this?  Memory problem?
> I've run several different embedded memory test programs on the PPC and
> they all pass fine.

You might still be having memory issues.  Memory tests in general
don't hit memory as hard and fast as running code with caches enabled.

>
> I've synthesized my FX60 with the exact same memory map as my FX12 on
> the ML403 and used the same kernel config.  ML403 works great.

>
> The only difference is that the FX60 board only has 32MB DDR, I have
> made sure that the correct memory size is in the kernel.

How are you booting your kernel?  .ace? u-boot? load via debugger?

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
