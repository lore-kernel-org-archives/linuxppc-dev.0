Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18669.29473.856007.689260@cargo.ozlabs.ibm.com>
Date: Thu, 9 Oct 2008 13:57:37 +1100
From: Paul Mackerras <paulus@samba.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: Fix error path in kernel_thread function
In-Reply-To: <20081007161003.GA5727@yoda.jdub.homelinux.org>
References: <20081007161003.GA5727@yoda.jdub.homelinux.org>
Cc: jpoimboe@us.ibm.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer writes:

> From: Josh Poimboeuf <jpoimboe@us.ibm.com>
> 
> The powerpc 32-bit and 64-bit kernel_thread functions don't properly
> propagate errors being returned by the clone syscall.  (In the case of
> error, the syscall exit code returns a positive errno in r3 and sets
> the CR0[SO] bit.)
> 
> This patch fixes that by negating r3 if CR0[SO] is set after the syscall.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@us.ibm.com>
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Acked-by: Paul Mackerras <paulus@samba.org>
