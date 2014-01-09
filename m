Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 57FD72C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jan 2014 02:29:47 +1100 (EST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH] KVM: PPC: e500: Fix bad address type in
 deliver_tlb_misss()
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1389279665-20970-1-git-send-email-mihai.caraman@freescale.com>
Date: Thu, 9 Jan 2014 16:29:40 +0100
Message-Id: <CB855D47-5AC0-4D70-9449-1D6A95E30102@suse.de>
References: <1389279665-20970-1-git-send-email-mihai.caraman@freescale.com>
To: Mihai Caraman <mihai.caraman@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "kvm@vger.kernel.org mailing list" <kvm@vger.kernel.org>,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 09.01.2014, at 16:01, Mihai Caraman <mihai.caraman@freescale.com> wrote:

> Use gva_t instead of unsigned int for eaddr in deliver_tlb_miss().
> 
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>

Thanks, applied to kvm-ppc-queue.


Alex
