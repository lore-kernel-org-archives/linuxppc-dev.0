Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id E8930DE20E
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 03:59:39 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: 1 GB lowmem
Date: Wed, 21 May 2008 13:00:12 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B046E79B3@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi

I am trying to enable 1 GB of lowmem on a Freescale 8280.
In arch/ppc this was easilly done by:
CONFIG_ADVANCED_OPTIONS=3Dy
CONFIG_HIGHMEM_START=3D0xfe000000
CONFIG_LOWMEM_SIZE_BOOL=3Dy
CONFIG_LOWMEM_SIZE=3D0x40000000
CONFIG_KERNEL_START_BOOL=3Dy
CONFIG_KERNEL_START=3D0xa0000000

This does not work in arch/powerpc. CPU hangs as soon as init starts.
Any ideas what to look at, what to change?

The reason I want to do this is because I cannot get highmem support to
work when using CONFIG_PREEMPT_RT.
(hitting a bug_on in kmap_atomic)
