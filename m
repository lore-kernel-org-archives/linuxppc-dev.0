Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17597.19430.983453.919592@cargo.ozlabs.ibm.com>
Date: Wed, 19 Jul 2006 07:00:22 +1000
From: Paul Mackerras <paulus@samba.org>
To: Mike Kravetz <kravetz@us.ibm.com>
Subject: Re: [PATCH 0/3] powerpc: Instrument Hypervisor Calls
In-Reply-To: <20060718204723.GA6104@w-mikek2.ibm.com>
References: <20060718204723.GA6104@w-mikek2.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mike Kravetz writes:

> A small update from the last version.  By popular demand, both
> wall time (mftb) and cpu cycles(PURR) are collected for each call.
> It is interesting to see these two values side by side in the
> output files.

Did you see the patch from Anton that I posted a week or so ago, which
reduces the number of plpar_hcall_* functions?  I'd rather the
instrumentation stuff was based on that.

My other comment is this: wouldn't it actually turn out simpler if we
read the timebase (and PURR, if we really want to do that too) in the
assembly code that implements plpar_hcall_*?

Paul.
