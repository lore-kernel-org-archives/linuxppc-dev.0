Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4DAB52C00CA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 09:54:52 +1100 (EST)
Message-ID: <1391036081.8524.80.camel@pasglop>
Subject: Re: [RFC PATCH 02/10] KVM: PPC: BOOK3S: PR: Emulate virtual
 timebase register
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
Date: Thu, 30 Jan 2014 09:54:41 +1100
In-Reply-To: <52E92EC6.2030607@suse.de>
References: <1390927455-3312-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1390927455-3312-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <52E92EC6.2030607@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-01-29 at 17:39 +0100, Alexander Graf wrote:
> static inline mfvtb(unsigned long)
> {
> #ifdef CONFIG_PPC_BOOK3S_64
>      return mfspr(SPRN_VTB);
> #else
>      BUG();
> #endif
> }
> 
> is a lot easier to read and get right. But reg.h is Ben's call.

Agreed.

> Also could you please give me a pointer to the specification for it? I 
> tried to look up vtb in the 2.06 ISA and couldn't find it. Is it a CPU 
> specific register?
