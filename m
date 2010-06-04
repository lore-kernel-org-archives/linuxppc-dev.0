Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3210AB7D1A
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jun 2010 00:08:37 +1000 (EST)
Subject: Re: [PATCH] kvm/powerpc: fix a build error in e500_tlb.c
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1275544348-3469-1-git-send-email-haokexin@gmail.com>
Date: Fri, 4 Jun 2010 16:08:28 +0200
Message-Id: <2D345913-D563-40A0-AC13-BE897B6F9B4C@suse.de>
References: <1275544348-3469-1-git-send-email-haokexin@gmail.com>
To: Kevin Hao <haokexin@gmail.com>
Cc: "kvm@vger.kernel.org list" <kvm@vger.kernel.org>,
	Marcelo Tosatti <mtosatti@redhat.com>, linuxppc-dev@ozlabs.org,
	Avi Kivity <avi@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 03.06.2010, at 07:52, Kevin Hao wrote:

> We use the wrong number arguments when invoking trace_kvm_stlb_inval,
> and cause the following build error.
> arch/powerpc/kvm/e500_tlb.c: In function =
'kvmppc_e500_stlbe_invalidate':
> arch/powerpc/kvm/e500_tlb.c:230: error: too many arguments to function =
'trace_kvm_stlb_inval'

Liu, I'd like to get an ack from you here.

Alex
