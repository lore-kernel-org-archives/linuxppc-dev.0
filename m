Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBB2d0b1XzDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 20:02:33 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 maddy@linux.vnet.ibm.com, hemant@linux.vnet.ibm.com, anju@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/powernv: Add kernel cmdline parameter to disable
 imc
In-Reply-To: <1507531597-25947-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1507531597-25947-1-git-send-email-anju@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 20:02:32 +1100
Message-ID: <87wp43wf2v.fsf@concordia.ellerman.id.au>
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

Anju T Sudhakar <anju@linux.vnet.ibm.com> writes:

> Add a kernel command line parameter option to disable In-Memory Collection
> (IMC) counters and add documentation. This helps in debug.

I'd really rather we didn't. Do we *really* need this?

We don't have command line parameters to disable any of the other ~20
PMUs, why is this one special?

cheers
