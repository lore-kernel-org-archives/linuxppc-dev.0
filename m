Return-Path: <linas@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 76CEFDDECE
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 02:47:19 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4AGlFhM008755
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 12:47:15 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4AGlF09475110
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 12:47:15 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4AGlER2021579
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 12:47:15 -0400
Date: Thu, 10 May 2007 11:47:11 -0500
To: Maxim Uvarov <muvarov@ru.mvista.com>
Subject: Re: [PATCH] Performance Stats: Kernel patch
Message-ID: <20070510164710.GC4452@austin.ibm.com>
References: <20070508162650.704.83752.stgit@localhost.localdomain>
	<20070508233200.GO4452@austin.ibm.com>
	<4642F27E.10700@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4642F27E.10700@ru.mvista.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	pavel@ucw.cz, wli@holomorphy.com, dada1@cosmosbay.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 10, 2007 at 10:22:54AM +0000, Maxim Uvarov wrote:
> Linas Vepstas wrote:
> >On Tue, May 08, 2007 at 04:26:51PM +0000, Maxim Uvarov wrote:
> >>+	addq $1, threadinfo_syscall_count(%rcx)   # Increment syscalls 
> >
> >again, #ifdef CONFIG_TASKSTATS,
> 
> So I don't really sure if  defines are needed in  entry.S code. I tried 
> to do
> some tests and  it is impossible to catch the performance difference (small
> overhead).

"A penny here, and a penny there, and pretty soon it adds up to real
money". Its a hot path, and its an easy fix. 

--linas
