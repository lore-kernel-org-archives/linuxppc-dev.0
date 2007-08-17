Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 71BC0DDE01
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 22:32:13 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7HCW97X023219
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 08:32:09 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7HCW9E8318722
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 08:32:09 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7HCW8oF032761
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 08:32:09 -0400
Date: Fri, 17 Aug 2007 07:30:28 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 0/3] Remove need for include/asm-ppc
Message-ID: <20070817073028.130728a0@zod.rchland.ibm.com>
In-Reply-To: <Pine.LNX.4.64.0708170157140.15311@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0708170157140.15311@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 17 Aug 2007 02:11:58 -0500 (CDT)
Kumar Gala <galak@kernel.crashing.org> wrote:

> This patch series removes the need for include/asm-ppc in the ARCH=powerpc
> build for ppc32.  They exist in the following git tree:
> 
>   master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git for-2.6.24
> 
> posting here for everyone else to see.

Did you happen to try building 44x with this series applied?  If not,
I'll give it a whirl later today.

josh
