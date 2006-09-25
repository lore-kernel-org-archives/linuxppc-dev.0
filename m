Return-Path: <peter.ryser@xilinx.com>
Received: from outbound4-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1162767B6C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Sep 2006 02:41:06 +1000 (EST)
Received: from outbound4-sin.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound4-sin-R.bigfish.com (Postfix) with ESMTP id 919481262E4A
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Sep 2006 16:17:47 +0000 (UTC)
Received: from mail42-sin-R.bigfish.com (unknown [10.3.252.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by outbound4-sin.bigfish.com (Postfix) with ESMTP id 7BFE812C0054
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Sep 2006 16:17:47 +0000 (UTC)
Received: from mail42-sin (localhost.localdomain [127.0.0.1])
	by mail42-sin-R.bigfish.com (Postfix) with ESMTP id 28068960252
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Sep 2006 16:17:47 +0000 (UTC)
Received: from newsgate.xilinx.com (gateway4.xilinx.com [149.199.60.204])
	by mail42-sin.bigfish.com (Postfix) with ESMTP id 65BB576005F
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Sep 2006 16:17:45 +0000 (UTC)
Received: from cliff.xilinx.com (cliff [149.199.38.103])
	by newsgate.xilinx.com (8.11.6p2/8.11.6) with ESMTP id k8PGHhi04356
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Sep 2006 09:17:43 -0700 (PDT)
Received: from xsj-exchfesmtp2.xlnx.xilinx.com (localhost [127.0.0.1])
	by cliff.xilinx.com (8.12.9/8.11.6) with ESMTP id k8PGIXBT029877
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Sep 2006 09:18:33 -0700 (PDT)
Message-ID: <451800D9.5010702@xilinx.com>
Date: Mon, 25 Sep 2006 09:16:25 -0700
From: Peter Ryser <peter.ryser@xilinx.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: Unable to boot linux on Xilinx ML403 board
References: <smtp_4517D0DE_85A0_0002.eml@>
In-Reply-To: <smtp_4517D0DE_85A0_0002.eml@>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


>avail ram:     00770000 08000000
>  
>

The ML403 only has 64 MB of RAM, ie. 0x04000000. For a start you can 
change the amount of memory Linux thinks it has available by adding
    mem=0x4000000
to the kernel command line like
    Linux/PPC load: console=tty1 console=ttyS0,9600 ip=off root=/dev/ram 
rw mem=0x4000000

Later, you want to change xparameters*.h in arch/ppc/platforms/xilinx_ocp

- Peter
