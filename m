Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 814FB2C016F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jun 2013 18:37:18 +1000 (EST)
Message-ID: <1371458225.21896.153.camel@pasglop>
Subject: Re: [PATCH 1/4] KVM: PPC: Add support for multiple-TCE hcalls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Mon, 17 Jun 2013 18:37:05 +1000
In-Reply-To: <51BEC0FE.4020805@ozlabs.ru>
References: <1370412673-1345-1-git-send-email-aik@ozlabs.ru>
 <1370412673-1345-2-git-send-email-aik@ozlabs.ru>
 <0A6C24DE-1422-4ABA-A516-2B864F4714F8@suse.de> <51BEC0FE.4020805@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Alexander Graf <agraf@suse.de>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-06-17 at 17:55 +1000, Alexey Kardashevskiy wrote:
> David:
> ===
> So, in the case of MULTITCE, that's not quite right.  PR KVM can
> emulate a PAPR system on a BookE machine, and there's no reason not to
> allow TCE acceleration as well.  We can't make it dependent on PAPR
> mode being selected, because that's enabled per-vcpu, whereas these
> capabilities are queried on the VM before the vcpus are created.
> ===
> 
> Wrong?

The capability just tells qemu the kernel supports it, it doesn't have
to depend on PAPR mode, qemu can sort things out no ?

Cheers,
Ben.
