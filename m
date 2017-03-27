Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vs9gj24FWzDqb9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Mar 2017 21:46:41 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: fenghua.yu@intel.com, tony.luck@intel.com, linux-ia64@vger.kernel.org,
 dyoung@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 ebiederm@xmission.com, Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, vgoyal@redhat.com
Subject: Re: [RESEND PATCH v4 5/5] powerpc/fadump: update documentation about
 crashkernel parameter reuse
In-Reply-To: <149035347559.6881.14224829694291758581.stgit@hbathini.in.ibm.com>
References: <149035332237.6881.9486330442785822384.stgit@hbathini.in.ibm.com>
 <149035347559.6881.14224829694291758581.stgit@hbathini.in.ibm.com>
Date: Mon, 27 Mar 2017 21:46:40 +1100
Message-ID: <87mvc7dmjz.fsf@concordia.ellerman.id.au>
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

Hari Bathini <hbathini@linux.vnet.ibm.com> writes:

> As we are reusing crashkernel parameter instead of fadump_reserve_mem
> parameter to specify the memory to reserve for fadump's crash kernel,
> update the documentation accordingly.
>
> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
> ---
>  Documentation/powerpc/firmware-assisted-dump.txt |   23 ++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
