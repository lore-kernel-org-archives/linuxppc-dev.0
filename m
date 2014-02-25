Return-Path: <cody@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BE65E2C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 08:14:17 +1100 (EST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Tue, 25 Feb 2014 14:14:15 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 035041FF003E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 14:14:14 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp08028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1PLEDQN7995680
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 22:14:13 +0100
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s1PLHeXf031905
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 14:17:41 -0700
Message-ID: <530D0796.6020704@linux.vnet.ibm.com>
Date: Tue, 25 Feb 2014 13:13:58 -0800
From: Cody P Schafer <cody@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>,
 Alexander Graf <agraf@suse.de>, Anton Blanchard <anton@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2 04/11] powerpc: add hvcalls for 24x7 and gpci (get
 performance counter info)
References: <20140225033327.878F52C0256@ozlabs.org>
In-Reply-To: <20140225033327.878F52C0256@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/24/2014 07:33 PM, Michael Ellerman wrote:
> On Fri, 2014-14-02 at 22:02:08 UTC, Cody P Schafer wrote:
>> Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/include/asm/hvcall.h | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
>> index d8b600b..652f7e4 100644
>> --- a/arch/powerpc/include/asm/hvcall.h
>> +++ b/arch/powerpc/include/asm/hvcall.h
>> @@ -274,6 +274,11 @@
>>   /* Platform specific hcalls, used by KVM */
>>   #define H_RTAS			0xf000
>>
>> +/* "Platform specific hcalls", provided by PHYP */
>> +#define H_GET_24X7_CATALOG_PAGE 0xF078
>> +#define H_GET_24X7_DATA		0xF07C
>> +#define H_GET_PERF_COUNTER_INFO 0xF080
>
> Some tabs some spaces, use tabs.

Ack.
