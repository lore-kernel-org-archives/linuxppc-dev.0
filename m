Return-Path: <rwoodworth@securics.com>
Received: from securics.com (dns2.securics.com [128.198.58.14])
	by ozlabs.org (Postfix) with ESMTP id 9A70FDDE09
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Sep 2007 06:58:14 +1000 (EST)
Received: from [192.168.0.38] (unknown [192.168.0.38])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by securics.com (Postfix) with ESMTP id EA4ACB8C0B9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Sep 2007 14:58:10 -0600 (MDT)
Subject: Xilinx FX60
From: Robert Woodworth <rwoodworth@securics.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Tue, 18 Sep 2007 14:58:10 -0600
Message-Id: <1190149090.7268.29.camel@PisteOff>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm back trying to get the kernel on my Xilinx FX60 without success. 
Now I have more information:


Using the Xilinx GDB, I'm getting either a "Bad Page fault exception" or
a kernel "oops"


The text in the _log_buf is as follows: 
(this happens before serial console init)

Data machine check in kernel mode..
Oops: machine check, sig: 7 [#1].
<register dump>



Any Ideas what would cause this?  Memory problem?  
I've run several different embedded memory test programs on the PPC and
they all pass fine.

I've synthesized my FX60 with the exact same memory map as my FX12 on
the ML403 and used the same kernel config.  ML403 works great.


The only difference is that the FX60 board only has 32MB DDR, I have
made sure that the correct memory size is in the kernel.



??
RJW
