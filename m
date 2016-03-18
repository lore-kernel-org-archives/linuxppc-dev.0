Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qRKNL6kd5zDqWw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 20:16:34 +1100 (AEDT)
Date: Fri, 18 Mar 2016 20:16:29 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Christian Zigotzky <chzigotzky@xenosoft.de>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel] KVM: PPC: Create a virtual-mode only TCE table
 handlers
Message-ID: <20160318091629.GD1393@fergus.ozlabs.ibm.com>
References: <1458269442-24292-1-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1458269442-24292-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 18, 2016 at 01:50:42PM +1100, Alexey Kardashevskiy wrote:
> Upcoming in-kernel VFIO acceleration needs different handling in real
> and virtual modes which makes it hard to support both modes in
> the same handler.
> 
> This creates a copy of kvmppc_rm_h_stuff_tce and kvmppc_rm_h_put_tce
> in addition to the existing kvmppc_rm_h_put_tce_indirect.
> 
> This also fixes linker breakage when only PR KVM was selected (leaving
> HV KVM off): the kvmppc_h_put_tce/kvmppc_h_stuff_tce functions
> would not compile at all and the linked would fail.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Acked-by: Paul Mackerras <paulus@samba.org>

Paolo, will you take this directly, or do you want me to generate
a pull request?

Paul.
