Return-Path: <e-grigore@criticalsoftware.com>
Received: from gate.criticalsoftware.com (gate.criticalsoftware.com
	[212.13.37.242]) by ozlabs.org (Postfix) with ESMTP id 981AEDE9A0
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 04:52:47 +1000 (EST)
Received: from [192.168.1.70] (unknown [192.168.1.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by gate.criticalsoftware.com (Postfix) with ESMTP id 6FBEBE8614
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 19:31:14 +0100 (WEST)
Message-ID: <488E1134.6010109@criticalsoftware.com>
Date: Mon, 28 Jul 2008 19:34:28 +0100
From: mihaela elena grigore <e-grigore@criticalsoftware.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: linux kernel for ppc as elf relocatable
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Can somebody help me with a few indications regarding how to obtain a 
relocatable vmlinux when compiling the linux kernel for ppc32 ?

For powerpc, by default, the building process results in an ELF 32-bit 
MSB executable statically linked. I saw that for other architectures it 
builds, by default, a relocatable elf file.

Why is it statically linked for some architectures and relocatable for 
others ? How to make it relocatable for ppc32? I assume that changing 
LDFLAGS_vmlinux to '-r' in the Makefile for ppc is not enough... (i'm 
using 2.6.11)

p.s. any comments/answers to my posting, please add me in CC, as i 
didn't subscribe, thank you.
