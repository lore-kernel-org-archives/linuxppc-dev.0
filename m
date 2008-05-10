Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (E23SMTP06.au.ibm.com [202.81.18.175])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4C3E5DDE32
	for <linuxppc-dev@ozlabs.org>; Sun, 11 May 2008 02:43:59 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id m4AGhWg3002343
	for <linuxppc-dev@ozlabs.org>; Sun, 11 May 2008 02:43:32 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4AGhmMD3457024
	for <linuxppc-dev@ozlabs.org>; Sun, 11 May 2008 02:43:48 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4AGhwfA023083
	for <linuxppc-dev@ozlabs.org>; Sun, 11 May 2008 02:43:58 +1000
Message-ID: <4825D0CC.8040501@linux.vnet.ibm.com>
Date: Sat, 10 May 2008 22:13:56 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [BUG] 2.6.25-rc2-git4 - Regression Kernel oops  while running
	kernbench and tbench on powerpc
References: <47BC40BC.3040405@linux.vnet.ibm.com>
	<18427.11023.8067.795279@cargo.ozlabs.ibm.com>
	<47FB5C5A.5020104@linux.vnet.ibm.com>
	<18427.65299.403151.344959@cargo.ozlabs.ibm.com>
	<47FC5227.3030501@linux.vnet.ibm.com>
	<18435.11286.201115.396713@cargo.ozlabs.ibm.com>
	<48035C03.10104@linux.vnet.ibm.com>
	<18446.61538.620549.715043@cargo.ozlabs.ibm.com>
	<4810231B.6020105@linux.vnet.ibm.com>
	<18467.49613.367933.672004@cargo.ozlabs.ibm.com>
In-Reply-To: <18467.49613.367933.672004@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
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

Paul Mackerras wrote:
> Kamalesh Babulal writes:
> 
>> Thanks, after applying the patch the oops is not reproducible on the machine. The console
>> log had no message starting with SLB: or FWNMI:. I have updated the bugzilla also.
>>
>> Tested-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> 
> Could you test Linus' current git tree and see if you can reproduce
> the same problem now?  The patch I sent upstream was a little
> different from the one you tested, though it should have the same
> effect, and I would like to be sure that it is just as effective at
> fixing the bug.
> 
> Thanks,
> Paul.

Hi Paul,

The patch has the same effect. I tested the 2.6.26-rc1-git7 kernel and
the oops is not reproducible.

-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
