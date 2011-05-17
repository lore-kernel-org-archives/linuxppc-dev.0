Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 8F6D8B6EFE
	for <linuxppc-dev@ozlabs.org>; Tue, 17 May 2011 19:46:36 +1000 (EST)
Subject: Re: [PATCH 0/13] Hypervisor-mode KVM on POWER7
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20110511103443.GA2837@brick.ozlabs.ibm.com>
Date: Tue, 17 May 2011 11:46:34 +0200
Message-Id: <764651B6-6DDA-49DC-AA95-52CD86FF82D9@suse.de>
References: <20110511103443.GA2837@brick.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 11.05.2011, at 12:34, Paul Mackerras wrote:

> The following series of patches enable KVM to exploit the hardware
> hypervisor mode on 64-bit Power ISA Book3S machines.  At present only
> POWER7 is supported, but it would be easy to add other processors.
>=20
> Running the KVM host in hypervisor mode means that the guest can use
> both supervisor mode and user mode.  That means that the guest can
> execute supervisor-privilege instructions and access supervisor-
> privilege registers.  In addition the hardware directs most exceptions
> to the guest.  Thus we don't need to emulate any instructions in the
> host.  Generally, the only times we need to exit the guest are when it
> does a hypercall or when an external interrupt or host timer
> (decrementer) interrupt occurs.
>=20
> The focus of this KVM implementation is to run guests that use the
> PAPR (Power Architecture Platform Requirements) paravirtualization
> interface, which is the interface supplied by PowerVM on IBM pSeries
> machines.
>=20
> These patches are against Ben Herrenschmidt's next branch in his tree
> at git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git.

Very nice patches indeed :). Is there any way I can test them? I don't =
like pulling code that I couldn't run anywhere yet.


Alex
