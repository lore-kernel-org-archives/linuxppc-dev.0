Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18467.49613.367933.672004@cargo.ozlabs.ibm.com>
Date: Fri, 9 May 2008 13:15:25 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [BUG] 2.6.25-rc2-git4 - Regression Kernel oops  while running
	kernbench and tbench on powerpc
In-Reply-To: <4810231B.6020105@linux.vnet.ibm.com>
References: <47BC40BC.3040405@linux.vnet.ibm.com>
	<18427.11023.8067.795279@cargo.ozlabs.ibm.com>
	<47FB5C5A.5020104@linux.vnet.ibm.com>
	<18427.65299.403151.344959@cargo.ozlabs.ibm.com>
	<47FC5227.3030501@linux.vnet.ibm.com>
	<18435.11286.201115.396713@cargo.ozlabs.ibm.com>
	<48035C03.10104@linux.vnet.ibm.com>
	<18446.61538.620549.715043@cargo.ozlabs.ibm.com>
	<4810231B.6020105@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-next@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kamalesh Babulal writes:

> Thanks, after applying the patch the oops is not reproducible on the machine. The console
> log had no message starting with SLB: or FWNMI:. I have updated the bugzilla also.
> 
> Tested-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

Could you test Linus' current git tree and see if you can reproduce
the same problem now?  The patch I sent upstream was a little
different from the one you tested, though it should have the same
effect, and I would like to be sure that it is just as effective at
fixing the bug.

Thanks,
Paul.
