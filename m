Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EC3DEB7090
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Jul 2009 09:48:57 +1000 (EST)
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5F9D6DDDE7
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Jul 2009 09:48:57 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n68NhjG8000324
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Jul 2009 19:43:45 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n68NmpRa257180
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Jul 2009 19:48:51 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n68NmojL031563
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Jul 2009 19:48:51 -0400
Date: Wed, 8 Jul 2009 19:48:16 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: fix booke user_disable_single_step()
Message-ID: <20090708234816.GA14351@zod.rchland.ibm.com>
References: <1247096778.22069.1.camel@norville.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1247096778.22069.1.camel@norville.austin.ibm.com>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 08, 2009 at 06:46:18PM -0500, Dave Kleikamp wrote:
>On booke processors, gdb is seeing spurious SIGTRAPs when setting a
>watchpoint.
>
>user_disable_single_step() simply quits when the DAC is non-zero.  It should
>be clearing the DBCR0_IC and DBCR0_BT bits from the dbcr0 register and
>TIF_SINGLESTEP from the thread flag.
>
>Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>

I'll test this first thing in the morning.  At first glance it looks pretty
good.

josh
