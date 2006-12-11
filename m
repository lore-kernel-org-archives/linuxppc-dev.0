Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 03CD467BD7
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Dec 2006 22:21:28 +1100 (EST)
Message-ID: <457D3FFD.8000107@grandegger.com>
Date: Mon, 11 Dec 2006 12:24:45 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Ming Liu <eemingliu@hotmail.com>
Subject: Re: how to cross-compile netperf.
References: <BAY110-F2437D558E178369DB8669CB2D00@phx.gbl>
In-Reply-To: <BAY110-F2437D558E178369DB8669CB2D00@phx.gbl>
Content-Type: text/plain; charset=GB2312
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

Ming Liu wrote:
> Dear all,
> Maybe my question is not proper for this maillist but I really see some 
> friends who are using netperf to measure the netowrk performance from 
> this maillist. So I ask for help here.
> Could anyone please tell me how to cross-compile the Netperf which could 
> be run on my PowerPC 405 processor? I cannot find a detailed explanation 
> from the manual. After the downloading and untaring the package, I use 
> the command "./configure --host ppc CC=powerpc-405-linux-gnu-gcc". 
> However unfortunately it doesn't work and error " checking whether 
> setpgrp takes no argument... configure:error: cannot check setpgrp when 
> cross compiling" appears. My host system is X86_64 PC with linux OS and 
> my target system is PowerPC 405(Xilinx Virtex 4 FPGA) with linux 
> too(embedded Ml403 board from Xilinx company). In my condition, which 
> arguments shall I specify?
> If anyone can help, I wll really appreciate a lot.

$ echo "ac_cv_func_setpgrp_void=yes" > config.cache
$ ./configure --host ppc CC=powerpc-405-linux-gnu-gcc --config-cache

Wolfgang.
