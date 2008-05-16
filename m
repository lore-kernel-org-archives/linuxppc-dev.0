Return-Path: <leon.woestenberg@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id 58EB9DED80
	for <linuxppc-dev@ozlabs.org>; Sat, 17 May 2008 06:06:09 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so307836anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 13:06:08 -0700 (PDT)
Message-ID: <c384c5ea0805161306s7c3f41c5wf2b74e4c12954434@mail.gmail.com>
Date: Fri, 16 May 2008 22:06:07 +0200
From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
To: "Linux PPC" <linuxppc-dev@ozlabs.org>
Subject: Any benchmarks on PCIe performance MPC83xx?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

did anyone yet perform benchmarks on a combination of PCIe device
(off-the-shelf or custom) doing bulk data transfers, and bringing this
off the chip via GbE or SATA using a recent Linux kernel?

Also, can someone suggest a readily available PCIe device that has a
driver that is supported under Linux/ppc, and allows me to do such
benchmarks before we implement a custom PCIe target?

Thanks for any info.

Regards,
-- 
Leon
