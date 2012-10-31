Return-Path: <haren@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 026A12C00BE
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2012 07:09:03 +1100 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Wed, 31 Oct 2012 14:09:00 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 642163E40039
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2012 14:08:56 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q9VK8u47195456
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2012 14:08:56 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q9VK8u1Y011724
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2012 14:08:56 -0600
Message-ID: <50918557.60603@linux.vnet.ibm.com>
Date: Wed, 31 Oct 2012 13:08:55 -0700
From: Haren Myneni <haren@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/6] powerpc: Define CPU_FTR_HAS_PPR
References: <1351666334.32304.13.camel@hbabu-laptop>
 <423B952B-AB58-4BAB-87EE-9F666615AB6C@kernel.crashing.org>
In-Reply-To: <423B952B-AB58-4BAB-87EE-9F666615AB6C@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, mikey@neuling.org, anton@au1.ibm.com,
 paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/31/2012 06:25 AM, Kumar Gala wrote:
> 
> On Oct 31, 2012, at 1:52 AM, Haren Myneni wrote:
> 
>> [PATCH 2/6] powerpc: Define CPU_FTR_HAS_PPR
>>
>> CPU_FTR_HAS_PPR is defined for POWER7.
> 
> Would be nice if commit message spelled out what PPR is.
> 

Thanks, First patch described what PPR is. Agree, I will change this
commit.

>>
>> Signed-off-by: Haren Myneni <haren@us.ibm.com>
>> ---
>> arch/powerpc/include/asm/cputable.h |    6 ++++--
>> 1 files changed, 4 insertions(+), 2 deletions(-)
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
