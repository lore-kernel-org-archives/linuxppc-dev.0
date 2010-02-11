Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 40B2EB7CBB
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Feb 2010 03:19:29 +1100 (EST)
Received: from sesr04.transmode.se (sesr04.transmode.se [192.168.201.15])
	by gw1.transmode.se (Postfix) with ESMTP id D4F5F650002
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Feb 2010 17:19:23 +0100 (CET)
Subject: Endian/__BYTE_ORDER question
To: linuxppc-dev@ozlabs.org
Message-ID: <OF43B135B0.EF8D9CB9-ONC12576C7.00588245-C12576C7.00598135@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 11 Feb 2010 17:17:37 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


I am getting confused about on how to test for Endian in the kernel code. In user
space one uses #if __BYTE_ORDER == __LITTLE_ENDIAN or #if __BYTE_ORDER == __BIG_ENDIAN

I can see lots of kernel headers using this test too, but it doesn't seem
to be an arch specific file #defining __BYTE_ORDER. Instead I find files like:
 arch/alpha/math-emu/sfp-util.h
 arch/powerpc/include/asm/sfp-machine.h
 arch/s390/include/asm/sfp-util.h
 arch/sh/math-emu/sfp-util.h

How is this supposed to work?

    Jocke
