Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 478C5B7BC7
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Nov 2009 19:47:35 +1100 (EST)
Subject: Re: [PATCH 14/27] Add book3s_64 specific opcode emulation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200911040943.46617.arnd@arndb.de>
References: <1256917647-6200-1-git-send-email-agraf@suse.de>
	<280C9FF6-1C52-4856-9F60-15DA0659FC31@suse.de>
	<1257284313.7907.80.camel@pasglop> <200911040943.46617.arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 04 Nov 2009 19:47:21 +1100
Message-ID: <1257324441.13611.55.camel@pasglop>
Mime-Version: 1.0
Cc: Kevin Wolf <kwolf@redhat.com>, Hollis Blanchard <hollisb@us.ibm.com>,
	Marcelo Tosatti <mtosatti@redhat.com>, Alexander Graf <agraf@suse.de>,
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

On Wed, 2009-11-04 at 09:43 +0100, Arnd Bergmann wrote:
> On Tuesday 03 November 2009, Benjamin Herrenschmidt wrote:
> > (Though glibc can be nasty, afaik it might load up optimized
> variants of
> > some routines with hard wired cache line sizes based on the CPU
> type)
> 
> You can also get application with hand-coded cache optimizations
> that are even harder, if not impossible, to fix. 

Right. But those are already broken across CPU variants anyways.

Cheers,
Ben
