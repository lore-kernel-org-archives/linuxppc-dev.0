Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMz226XZRzDqL1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 21:20:10 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, lsorense@csclub.uwaterloo.ca,
 oohall@gmail.com, naveen.n.rao@linux.vnet.ibm.com, ast@kernel.org,
 chris@distroguy.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 anton@samba.org, paul.gortmaker@windriver.com, bauerman@linux.vnet.ibm.com,
 viro@zeniv.linux.org.uk, christophe.leroy@c-s.fr, duwe@lst.de,
 oss@buserror.net, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/2] powerpc: Emulation support for load/store
 instructions on LE
In-Reply-To: <1487063803-10848-2-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
References: <1487063803-10848-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1487063803-10848-2-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Date: Tue, 14 Feb 2017 21:20:09 +1100
Message-ID: <87d1elm5uu.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> writes:

> emulate_step() uses a number of underlying kernel functions that were
> initially not enabled for LE. This has been rectified since.

When exactly? ie. which commit.

Should we backport this? ie. is it actually a bug people are hitting in
the real world much?

cheers
