Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1C908100C89
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Nov 2009 17:04:05 +1100 (EST)
Subject: Re: [PATCH 00/27] Add KVM support for Book3s_64 (PPC64) hosts v6
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
In-Reply-To: <1256917647-6200-1-git-send-email-agraf@suse.de>
References: <1256917647-6200-1-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 05 Nov 2009 17:03:52 +1100
Message-ID: <1257401032.13611.101.camel@pasglop>
Mime-Version: 1.0
Cc: Kevin Wolf <kwolf@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Hollis Blanchard <hollisb@us.ibm.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	kvm-ppc <kvm-ppc@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Avi Kivity <avi@redhat.com>, kvm@vger.kernel.org,
	bphilips@suse.de, Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-10-30 at 16:47 +0100, Alexander Graf wrote:
> KVM for PowerPC only supports embedded cores at the moment.
> 
> While it makes sense to virtualize on small machines, it's even more fun
> to do so on big boxes. So I figured we need KVM for PowerPC64 as well.

I get that with exit timing enabled:

arch/powerpc/kvm/timing.c:205: error: ‘THIS_MODULE’ undeclared here (not in a function)

I'll stick a fixup patch in my tree (just adding #include <linux/module.h>)

Cheers,
Ben.
