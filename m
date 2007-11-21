Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3A45FDDDE6
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 15:45:50 +1100 (EST)
Message-Id: <53FD3FB3-960E-48B8-8FF3-8233FDCD5B61@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18243.41278.72798.100000@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] sys_indirect kernel implementation for PowerPC
Date: Tue, 20 Nov 2007 22:45:34 -0600
References: <18243.41278.72798.100000@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 20, 2007, at 9:08 PM, Paul Mackerras wrote:

> This implements sys_indirect for 32-bit and 64-bit powerpc machines,
> including a 32-bit compatibility implementation for 64-bit powerpc.
> I decided to use assembly language for call_syscall because on 64-bit
> powerpc the system call table has the addresses of the function text
> rather than pointers to function descriptors; hence the system call
> functions can't be called from C via the system call table.

Admit it you were bored and wanted to write some PPC asm ;)

- k
