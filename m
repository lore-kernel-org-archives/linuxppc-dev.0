Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18604.63159.163718.167197@drongo.ozlabs.ibm.com>
Date: Thu, 21 Aug 2008 15:01:43 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: powerpc allmodconfig in current -mm
In-Reply-To: <20080820181626.0347c270.akpm@linux-foundation.org>
References: <20080820181626.0347c270.akpm@linux-foundation.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew Morton writes:

> /opt/crosstool/gcc-4.1.0-glibc-2.3.6/powerpc64-unknown-linux-gnu/bin/powerpc64-unknown-linux-gnu-ld: .tmp_vmlinux1: section .data.gcov lma 0xc000000002c2bb78 overlaps previous sections

I suspect your binutils are too old, and the stress that the gcov
stuff puts on the toolchain is showing up a bug in ld.

> powerpc allmodconfig:
> 
> ERROR: "CMO_PageSize" [arch/powerpc/platforms/pseries/cmm.ko] undefined!
> 
> (needed for 2.6.27)

OK.  I think we need to export CMO_PrPSP and CMO_SecPSP as well.
(Lovely names. :()

Paul.
