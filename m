Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8D996DE7F0
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 21:55:43 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m3ABtdQe009627
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 07:55:39 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3ABtdcl278724
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 07:55:39 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m3ABtdZ8015371
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 07:55:39 -0400
Date: Thu, 10 Apr 2008 06:53:37 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Jerone Young <jyoung5@us.ibm.com>
Subject: Re: [PATCH] [v5] Add idle wait support for 44x platforms
Message-ID: <20080410065337.2152828e@zod.rchland.ibm.com>
In-Reply-To: <df0f79b7b4ab628887c2.1207673354@thinkpadL>
References: <df0f79b7b4ab628887c2.1207673354@thinkpadL>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: kvm-ppc-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 08 Apr 2008 11:49:14 -0500
Jerone Young <jyoung5@us.ibm.com> wrote:

> 2 files changed, 77 insertions(+), 1 deletion(-)
> arch/powerpc/platforms/44x/Makefile |    2 
> arch/powerpc/platforms/44x/idle.c   |   76 +++++++++++++++++++++++++++++++++++
> 
> 
> Updates: Now setting MSR_WE is now default
>          Tested on hardware platforms bamboo & sequioa and appears
>          things are working fine on actually hardware!
> 
> This patch adds the ability for the CPU to go into wait state while in cpu_idle loop. This helps virtulization solutions know when the guest Linux kernel is in an idle state. There are two ways to do it.
> 
> Command line
> 	idle=spin <-- CPU will spin
> 	idle=wait <-- set CPU into wait state when idle (default)
> 
> 
> Signed-off-by: Jerone Young <jyoung5@us.ibm.com>

Looks great.  I'll add it to my tree shortly.

josh
