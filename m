Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B3FD1A2AD3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 08:21:36 +1100 (AEDT)
In-Reply-To: <550FD09C.1060909@suse.de>
References: <20150317103356.27872.65515.stgit@mars> <550FD09C.1060909@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH v2] powerpc/book3s: Fix the MCE code to use
 CONFIG_KVM_BOOK3S_64_HANDLER
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 24 Mar 2015 08:21:34 +1100
To: Alexander Graf <agraf@suse.de>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>
Message-ID: <CA2D1B9D-D033-41C9-8E70-BE6AA439A99A@ellerman.id.au>
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



On 23 March 2015 19:36:44 GMT+11:00, Alexander Graf <agraf@suse.de> wrote:
>
>
>On 17.03.15 11:44, Mahesh J Salgaonkar wrote:
>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>> 
>> commit id 2ba9f0d has changed CONFIG_KVM_BOOK3S_64_HV to tristate to
>allow
>> HV/PR bits to be built as modules. But the MCE code still depends on
>> CONFIG_KVM_BOOK3S_64_HV which is wrong. When user selects
>> CONFIG_KVM_BOOK3S_64_HV=m to build HV/PR bits as a separate module
>the
>> relevant MCE code gets excluded.
>> 
>> This patch fixes the MCE code to use CONFIG_KVM_BOOK3S_64_HANDLER.
>This
>> makes sure that the relevant MCE code is included when HV/PR bits
>> are built as a separate modules.
>> 
>> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>
>Please CC the kvm@vger and kvm-ppc@vger mailing lists on patches that
>are KVM related.
>
>In this case, please resend with the proper CCs, so that I can pick it
>up into my queue :). Also on resend add the lines that Paul suggested
>(CC: stable, Acked-by) after your SoB line.

I already picked this up into my fixes branch.

cheers

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
