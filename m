Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18687.61506.924500.411952@drongo.ozlabs.ibm.com>
Date: Thu, 23 Oct 2008 14:32:18 +1100
From: Paul Mackerras <paulus@samba.org>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 3/3] powerpc/ppc64/kdump: better flag for running
	relocatable
In-Reply-To: <kexec-kern-2@bga.com>
References: <f90d4d7306443a720ca31adf513faf25@bga.com> <kexec-kern-2@bga.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Milton Miller writes:

> Move the flag to 0x5c, 1 word before the secondary cpu entry point at
> 0x60.  Use the copy at address 0 not the one in the base kernel image to
> make it easier on kexec-tools.

Why is it easier on kexec-tools?  Doesn't kexec-tools know where it
put the kernel?

I'd much rather keep the flag inside the kdump kernel image, rather
than having kexec/kdump start using random fixed locations outside the
new kernel image.

Paul.
