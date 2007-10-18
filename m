Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18199.20538.594159.877930@cargo.ozlabs.ibm.com>
Date: Thu, 18 Oct 2007 22:23:22 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: 2.6.23-mm1 - powerpc - Build fails at arch/powerpc/boot/inflate.o
In-Reply-To: <47174C49.5050308@linux.vnet.ibm.com>
References: <20071011213126.cf92efb7.akpm@linux-foundation.org>
	<47174C49.5050308@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kamalesh Babulal writes:

> The kernel build fails on the power box
> 
>   INSTALL vdso64.so
> 
>   INSTALL vdso32.so
> 
>   BOOTCC  arch/powerpc/boot/inflate.o
> 
> arch/powerpc/boot/inflate.c:920:19: error: errno.h: No such file or directory

This problem is fixed by d4faaecbcc6d9ea4f7c05f6de6af98e2336a4afb in
Linus' tree.

Paul.
