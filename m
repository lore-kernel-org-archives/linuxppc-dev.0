Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9906C2C00AB
 for <linuxppc-dev@ozlabs.org>; Tue, 26 Nov 2013 21:16:51 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 26 Nov 2013 15:46:45 +0530
Message-ID: <529474C7.9050005@linux.vnet.ibm.com>
Date: Tue, 26 Nov 2013 15:45:35 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "mpe@ellerman.id.au" <michael@ozlabs.org>
Subject: Re: [V3 01/10] perf: New conditional branch filter criteria in branch
 stack sampling
References: <20131126060618.917ED2C00A9@ozlabs.org>
In-Reply-To: <20131126060618.917ED2C00A9@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mikey@neuling.org, michaele@au1.ibm.com, linux-kernel@vger.kernel.org,
 eranian@google.com, linuxppc-dev@ozlabs.org, sukadev@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/26/2013 11:36 AM, mpe@ellerman.id.au wrote:
> Ideally your commit subject would contain a verb, preferably in the present
> tense.
> 
> I think simply "perf: Add PERF_SAMPLE_BRANCH_COND" would be clearer.


Sure, will change it.

> 
> On Wed, 2013-16-10 at 06:56:48 UTC, Anshuman Khandual wrote:
>> POWER8 PMU based BHRB supports filtering for conditional branches.
>> This patch introduces new branch filter PERF_SAMPLE_BRANCH_COND which
>> will extend the existing perf ABI. Other architectures can provide
>> this functionality with either HW filtering support (if present) or
>> with SW filtering of instructions.
>>
>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> Reviewed-by: Stephane Eranian <eranian@google.com>
>> ---
>>  include/uapi/linux/perf_event.h | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
>> index 0b1df41..5da52b6 100644
>> --- a/include/uapi/linux/perf_event.h
>> +++ b/include/uapi/linux/perf_event.h
>> @@ -160,8 +160,9 @@ enum perf_branch_sample_type {
>>  	PERF_SAMPLE_BRANCH_ABORT_TX	= 1U << 7, /* transaction aborts */
>>  	PERF_SAMPLE_BRANCH_IN_TX	= 1U << 8, /* in transaction */
>>  	PERF_SAMPLE_BRANCH_NO_TX	= 1U << 9, /* not in transaction */
>> +	PERF_SAMPLE_BRANCH_COND		= 1U << 10, /* conditional branches */
>>  
>> -	PERF_SAMPLE_BRANCH_MAX		= 1U << 10, /* non-ABI */
>> +	PERF_SAMPLE_BRANCH_MAX		= 1U << 11, /* non-ABI */
>>  };
> 
> This no longer applies against Linus' tree, you'll need to rebase it.

Okay
