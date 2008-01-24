Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18328.2461.82013.777187@cargo.ozlabs.ibm.com>
Date: Thu, 24 Jan 2008 14:44:29 +1100
From: Paul Mackerras <paulus@samba.org>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH 1/4 v4] POWERPC: Add _nmask_and_or_msr() declartion to
	asm-powerpc/system.h
In-Reply-To: <E1JHkY3-00010P-V2@jdl.com>
References: <E1JHkY3-00010P-V2@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Loeliger writes:

> +extern void _nmask_and_or_msr(unsigned long nmask, unsigned long or_val);

Hmmm, I wish someone would think of a better name for it.  In fact I
have tended to avoid using it, and instead done things like

	mtmsr((mfmsr() & ~x) | y);

where necessary instead.

Paul.
