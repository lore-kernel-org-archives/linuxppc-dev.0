Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id 9D08A67A3F
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Mar 2006 08:12:03 +1100 (EST)
Date: 3 Mar 2006 21:12:01 -0000
Message-ID: <20060303211201.1454.qmail@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: powerpc: set ARCH_KMALLOC_MINALIGN if CONFIG_NOT_COHERENT_CACHE=y
In-Reply-To: <20060303200928.GA29099@xyzzy.farnsworth.org>
Cc: 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In article <20060303200928.GA29099@xyzzy.farnsworth.org> you write:
> Ensure that buffers returned by kmalloc do not share a cache
> line with other data when doing non-cache-coherent I/O.

Eugene Surovegin points out that ARCH_KMALLOC_MINALIGN
doesn't work as avertised.

This patch doesn't work.

Thanks,
-Dale
