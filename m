Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D69B1A1D30
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 04:57:34 +1000 (AEST)
Subject: Re: [PATCH v3 1/1] KVM: PPC: Book3S: correct width in XER handling
To: Laurent Vivier <lvivier@redhat.com>
References: <edf0cbb1d82070438f6b03f55e35347ef996503d.1432684609.git.sam.bobroff@au1.ibm.com>
 <20150806012541.GA6697@tungsten.ozlabs.ibm.com> <55C333F9.3010003@redhat.com>
Cc: Sam Bobroff <sam.bobroff@au1.ibm.com>, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
From: Alexander Graf <agraf@suse.de>
Message-ID: <55CB9718.80803@suse.de>
Date: Wed, 12 Aug 2015 20:57:28 +0200
MIME-Version: 1.0
In-Reply-To: <55C333F9.3010003@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 06.08.15 12:16, Laurent Vivier wrote:
> Hi,
> 
> I'd also like to see this patch in the mainstream as it fixes a bug
> appearing when we switch from vCPU context to hypervisor context (guest
> crash).

Thanks, applied to kvm-ppc-queue.


Alex
