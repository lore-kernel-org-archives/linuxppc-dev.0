Return-Path: <gerlach@kip.uni-heidelberg.de>
Received: from relay.uni-heidelberg.de (relay.uni-heidelberg.de
	[129.206.100.212])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9A162DDE16
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Sep 2007 00:55:07 +1000 (EST)
Received: from mail.kip.uni-heidelberg.de (mail.kip.uni-heidelberg.de
	[129.206.127.243])
	by relay.uni-heidelberg.de (8.14.1/8.14.1) with ESMTP id l84E0DF0002683
	for <linuxppc-embedded@ozlabs.org>; Tue, 4 Sep 2007 16:00:13 +0200
Received: from [129.206.177.160] (seven.kip.uni-heidelberg.de
	[129.206.177.160])
	by mail.kip.uni-heidelberg.de (Postfix) with ESMTP id 2583F4BBDF
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Sep 2007 16:00:13 +0200 (CEST)
Message-ID: <46DD65BF.5090304@kip.uni-heidelberg.de>
Date: Tue, 04 Sep 2007 16:03:43 +0200
From: Thomas Gerlach <gerlach@kip.uni-heidelberg.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Newbie on embedded linux on PPC: error: cannot find boot.o
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hi folks,


my name is thomas trying to make embedded linux run on a powerpc, but we've got special boards here, although we use a xilinx virtex4 fpga...

as you said in the nabble-thread (see subject), i set up edk9.1 software platform settings und ran libgen to get the xparameters* files. i copied those bsp files into the kernel tree (i use your kernel linux-2.6-virtex from git.secretlabs.ca/git). after configuring the kernel settigs, i try

$ make ARCH=ppc CROSS_COMPILE=powerpc-eabi-

what i get is the following output:

>   CHK     include/linux/version.h
>   CHK     include/linux/utsrelease.h
>   CALL    scripts/checksyscalls.sh
>   CHK     include/linux/compile.h
>   LD      init/mounts.o
> powerpc-eabi-ld: cannot find boot.o
> make[1]: *** [init/mounts.o] Error 1
> make: *** [init] Error 2

so, i searched for boot.o (it exists) and even copied it into several dirs of the linux kernel tree (where i thought i would make sense), but the problem still remains.

googling results in

http://www.xilinx.com/xlnx/xil_ans_display.jsp?iLanguageID=1&getPagePath=17462&BV_SessionID=@@@@1197140711.1188909240@@@@&BV_EngineID=cccgaddllgmfkflcefeceihdffhdfkf.0

and this, too, doesn't take me further in solving the problem.

i hope you can help me.

many thanks in advance,

kind regards

thomas gerlach
