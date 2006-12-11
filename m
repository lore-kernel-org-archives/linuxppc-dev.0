Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc3-s14.bay0.hotmail.com (bay0-omc3-s14.bay0.hotmail.com
	[65.54.246.214]) by ozlabs.org (Postfix) with ESMTP id AAA8867BB6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Dec 2006 01:01:59 +1100 (EST)
Message-ID: <BAY110-F272AA38C88E00A0CCF19EAB2D00@phx.gbl>
In-Reply-To: <457D3FFD.8000107@grandegger.com>
From: "Ming Liu" <eemingliu@hotmail.com>
To: wg@grandegger.com
Subject: Re: how to cross-compile netperf.
Date: Mon, 11 Dec 2006 14:01:56 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
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

Dear Wolfgang,
Yes! It helps.

Thanks so much for your kindly help.

BR
Ming


>From: Wolfgang Grandegger <wg@grandegger.com>
>To: Ming Liu <eemingliu@hotmail.com>
>CC: linuxppc-embedded@ozlabs.org
>Subject: Re: how to cross-compile netperf.
>Date: Mon, 11 Dec 2006 12:24:45 +0100
>
>Ming Liu wrote:
> > Dear all,
> > Maybe my question is not proper for this maillist but I really see some
> > friends who are using netperf to measure the netowrk performance from
> > this maillist. So I ask for help here.
> > Could anyone please tell me how to cross-compile the Netperf which 
could
> > be run on my PowerPC 405 processor? I cannot find a detailed 
explanation
> > from the manual. After the downloading and untaring the package, I use
> > the command "./configure --host ppc CC=powerpc-405-linux-gnu-gcc".
> > However unfortunately it doesn't work and error " checking whether
> > setpgrp takes no argument... configure:error: cannot check setpgrp when
> > cross compiling" appears. My host system is X86_64 PC with linux OS and
> > my target system is PowerPC 405(Xilinx Virtex 4 FPGA) with linux
> > too(embedded Ml403 board from Xilinx company). In my condition, which
> > arguments shall I specify?
> > If anyone can help, I wll really appreciate a lot.
>
>$ echo "ac_cv_func_setpgrp_void=yes" > config.cache
>$ ./configure --host ppc CC=powerpc-405-linux-gnu-gcc --config-cache
>
>Wolfgang.

_________________________________________________________________
√‚∑—œ¬‘ÿ MSN Explorer:   http://explorer.msn.com/lccn/  
