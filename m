Return-Path: <tmorrison@empirix.com>
Received: from empbedex1.empirix.com (empbedex1.empirix.com [12.38.203.54])
	by ozlabs.org (Postfix) with ESMTP id 1E39CDDE46
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 02:15:11 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Problem with PHYS_64BIT on E500 Core (2.6.23.1)
Date: Tue, 6 Nov 2007 10:02:57 -0500
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D9010A9110E1@EMPBEDEX.empirix.com>
In-Reply-To: <mailman.2202.1194358987.3099.linuxppc-dev@ozlabs.org>
References: <mailman.2202.1194358987.3099.linuxppc-dev@ozlabs.org>
From: "Morrison, Tom" <tmorrison@empirix.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have a MPC8548E Board in which with an earlier version of=20
the kernel (2.6.11++), we customized head_e500.S and other=20
files to support the PHYS_64BIT & PTE_64BIT based upon=20
the work done for PPC64. It works very well.

I am attempting to update our kernel to the latest and have
gotten the basic system up & running (with some hacks/problems
that I won't until I am finished). We are using cuboot.85xx=20
image because our u-boot does NOT support dtb.

I noticed that the head_fsl_booke.S had the Large Physical=20
Address support, and I ported the other changes required, but
I get nowhere close to the code before the processor hangs.
I have tracked it down to where it is booting into the vmlinux
(which I assume is into the head_fsl_booke.S). We haven't=20
hooked a debugger up to this yet - but I am positive that it
isn't making out of this initialization code in the initial=20
assembly code.

The question is: Has anyone actually tried this to do this yet?

Thanks in advance for your responses!

Tom Morrison
Principal S/W Engineer
Empirix, Inc (www.empirix.com)
tmorrison@empirix.com
(781) 266 - 3567
