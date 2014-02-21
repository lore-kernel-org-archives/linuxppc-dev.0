Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9B2292C0338
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Feb 2014 02:57:41 +1100 (EST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH] PPC: KVM: Introduce hypervisor call H_GET_TCE
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20140221153110.8190.6271.stgit@nimbus>
Date: Fri, 21 Feb 2014 16:57:31 +0100
Message-Id: <75FB1EEB-910A-49A9-A4CC-0A2E5403C54C@suse.de>
References: <20140221153110.8190.6271.stgit@nimbus>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: "kvm@vger.kernel.org mailing list" <kvm@vger.kernel.org>,
 Gleb Natapov <gleb@kernel.org>, kvm-ppc <kvm-ppc@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 21.02.2014, at 16:31, Laurent Dufour <ldufour@linux.vnet.ibm.com> =
wrote:

> This fix introduces the H_GET_TCE hypervisor call which is basically =
the
> reverse of H_PUT_TCE, as defined in the Power Architecture Platform
> Requirements (PAPR).
>=20
> The hcall H_GET_TCE is required by the kdump kernel which is calling =
it to
> retrieve the TCE set up by the panicing kernel.
>=20
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>

Thanks, applied to kvm-ppc-queue. Btw, why exactly are we using struct =
page pointers and alloc_page rather than __get_free_page() and simple =
page start pointers?


Alex
