Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vdQ6h74f7zDqY3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 18:25:48 +1100 (AEDT)
In-Reply-To: <1487063803-10848-2-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: duwe@lst.de, ast@kernel.org, viro@zeniv.linux.org.uk, chris@distroguy.com,
 oss@buserror.net, paul.gortmaker@windriver.com, oohall@gmail.com,
 aneesh.kumar@linux.vnet.ibm.com, lsorense@csclub.uwaterloo.ca,
 bauerman@linux.vnet.ibm.com, paulus@samba.org, naveen.n.rao@linux.vnet.ibm.com,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, anton@samba.org
Subject: Re: [v3,
 1/2] powerpc: Emulation support for load/store instructions on LE
Message-Id: <3vdQ6h69JWz9sNC@ozlabs.org>
Date: Wed,  8 Mar 2017 18:25:48 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-02-14 at 09:16:42 UTC, Ravi Bangoria wrote:
> emulate_step() uses a number of underlying kernel functions that were
> initially not enabled for LE. This has been rectified since. So, fix
> emulate_step() for LE for the corresponding instructions.
> 
> Reported-by: Anton Blanchard <anton@samba.org>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

Series applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/e148bd17f48bd17fca2f4f089ec879

cheers
