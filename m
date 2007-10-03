Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CEE91DDE01
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 23:42:16 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l93DgDo0013979
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Oct 2007 09:42:13 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l93DgDkE431396
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Oct 2007 07:42:13 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l93DgDvh022824
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Oct 2007 07:42:13 -0600
Date: Wed, 3 Oct 2007 08:42:11 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: Re: Please pull from 'for-2.6.24' branch of 4xx tree
Message-ID: <20071003084211.61f52e3a@weaponx.rchland.ibm.com>
In-Reply-To: <20071002075420.0182bb7c@weaponx.rchland.ibm.com>
References: <20071002075420.0182bb7c@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2 Oct 2007 07:54:20 -0500
Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:

> Hi Paul,
> 
> Please pull from
> 
>  master.kernel.org:/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git for-2.6.24
> 
> to pick up a handful of new items for 2.6.24.  Initial Virtex support
> from Grant, some cpu setup functions for 4xx from Valentine, a compile
> fix for the Walnut wrapper, and a small number of arch/ppc fixes for
> Xilinx boards.

I've rebased my branch on top of your latest tree and added the
following two additional commits:

Grant Likely (2):
      [POWERPC] Uartlite: Add macros for register names
      [POWERPC] Uartlite: Revert register io access changes

Please pull

thx,
josh
