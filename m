Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdJXW1GFPzDqY9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 19:14:51 +1000 (AEST)
Date: Thu, 24 Aug 2017 19:13:13 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: nixiaoming <nixiaoming@huawei.com>, David Hildenbrand <david@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2] KVM: PPC: Book3S: Fix race and leak in
 kvm_vm_ioctl_create_spapr_tce()
Message-ID: <20170824091313.GF27401@fergus.ozlabs.ibm.com>
References: <20170824091138.GE27401@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170824091138.GE27401@fergus.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 24, 2017 at 07:11:38PM +1000, Paul Mackerras wrote:

Ignore this.  My apologies.

Paul.
