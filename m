Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rXzrV1PN1zDqCX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 15:27:22 +1000 (AEST)
Date: Mon, 20 Jun 2016 15:25:13 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Li Zhong <zhong@linux.vnet.ibm.com>
Cc: kvm-ppc@vger.kernel.org,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>, agraf@suse.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC PATCH 1/2] KVM: PPC: divide the ics lock into smaller ones
 for each irq
Message-ID: <20160620052513.GB29366@fergus.ozlabs.ibm.com>
References: <1463381898.19947.6.camel@TP420>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1463381898.19947.6.camel@TP420>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 16, 2016 at 02:58:18PM +0800, Li Zhong wrote:
> This patch tries to use smaller locks for each irq in the ics, instead
> of a lock at the ics level, to provide better scalability.

This looks like a worth-while thing to do.  Do you have any
performance measurements to justify the change?  This will increase
the size of struct kvmppc_ics by 4kB, so it would be useful to show
the performance increase that justifies it.

Also, when you resend the patch, please make the patch description
more definite - say "With this patch, we use" rather than "this patch
tries to use", for instance.

Regards,
Paul.
