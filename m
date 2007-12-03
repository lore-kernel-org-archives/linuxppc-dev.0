Return-Path: <srinivasa@in.ibm.com>
Received: from e23smtp06.au.ibm.com (E23SMTP06.au.ibm.com [202.81.18.175])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ED6BBDDD01
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Dec 2007 19:13:07 +1100 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id lB38D1PF027298
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Dec 2007 19:13:01 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB38GeAx196190
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Dec 2007 19:16:41 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB38CmYd027305
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Dec 2007 19:12:48 +1100
Message-ID: <4753BA8A.2070404@in.ibm.com>
Date: Mon, 03 Dec 2007 13:42:58 +0530
From: Srinivasa Ds <srinivasa@in.ibm.com>
MIME-Version: 1.0
To: Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 14/27] powerpc: ptrace generic resume
References: <20071125215507.4B89226F8C5@magilla.localdomain>
	<20071125220402.4C43C26F8DE@magilla.localdomain>
In-Reply-To: <20071125220402.4C43C26F8DE@magilla.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Roland McGrath wrote:
> This removes the handling for PTRACE_CONT et al from the powerpc
> ptrace code, so it uses the new generic code via ptrace_request.
 
   I have tested this patchset on powerpc successfully.

> 
> Signed-off-by: Roland McGrath <roland@redhat.com>
> ---
>  arch/powerpc/kernel/ptrace.c |   46 ------------------------------------------
>  1 files changed, 0 insertions(+), 46 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> index b970d79..8b056d2 100644
> --- a/arch/powerpc/kernel/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace.c
> @@ -445,52 +445,6 @@ long arch_ptrace(struct task_struct *child, long request, long addr, long data)
>  		break;
>  	}


Thanks
 Srinivasa DS
 Linux Technology Centre
 IBM.
