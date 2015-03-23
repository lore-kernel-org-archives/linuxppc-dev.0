Return-Path: <agraf@suse.de>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A8C3A1A2B00
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 19:36:48 +1100 (AEDT)
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1252A140146
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Mar 2015 19:36:48 +1100 (AEDT)
Message-ID: <550FD09C.1060909@suse.de>
Date: Mon, 23 Mar 2015 09:36:44 +0100
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2] powerpc/book3s: Fix the MCE code to use
 CONFIG_KVM_BOOK3S_64_HANDLER
References: <20150317103356.27872.65515.stgit@mars>
In-Reply-To: <20150317103356.27872.65515.stgit@mars>
Content-Type: text/plain; charset=utf-8
Cc: David Gibson <dgibson@redhat.com>, Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 17.03.15 11:44, Mahesh J Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> commit id 2ba9f0d has changed CONFIG_KVM_BOOK3S_64_HV to tristate to allow
> HV/PR bits to be built as modules. But the MCE code still depends on
> CONFIG_KVM_BOOK3S_64_HV which is wrong. When user selects
> CONFIG_KVM_BOOK3S_64_HV=m to build HV/PR bits as a separate module the
> relevant MCE code gets excluded.
> 
> This patch fixes the MCE code to use CONFIG_KVM_BOOK3S_64_HANDLER. This
> makes sure that the relevant MCE code is included when HV/PR bits
> are built as a separate modules.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Please CC the kvm@vger and kvm-ppc@vger mailing lists on patches that
are KVM related.

In this case, please resend with the proper CCs, so that I can pick it
up into my queue :). Also on resend add the lines that Paul suggested
(CC: stable, Acked-by) after your SoB line.


Alex
