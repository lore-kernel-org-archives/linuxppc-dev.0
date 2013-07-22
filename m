Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9D5B92C00D7
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Jul 2013 16:40:36 +1000 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 22 Jul 2013 12:03:43 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 407DC394007F
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Jul 2013 12:10:23 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6M6fHoW30212118
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Jul 2013 12:11:17 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6M6eRpN014432
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Jul 2013 16:40:27 +1000
Message-ID: <51ECD3B6.5050509@linux.vnet.ibm.com>
Date: Mon, 22 Jul 2013 12:09:50 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH V3 2/2] powerpc, perf: BHRB filter configuration should
 follow the task
References: <1370843609-32618-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1370843609-32618-3-git-send-email-khandual@linux.vnet.ibm.com>
 <32432.1372058442@ale.ozlabs.ibm.com>
In-Reply-To: <32432.1372058442@ale.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/24/2013 12:50 PM, Michael Neuling wrote:
> Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote:
> 
>> When the task moves around the system, the corresponding cpuhw
>> per cpu strcuture should be popullated with the BHRB filter
>> request value so that PMU could be configured appropriately with
>> that during the next call into power_pmu_enable().
>>
>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> 
> benh you might want to fix the spelling mistakes above 
> 
>   strcuture -> structure
>   popullated -> populated
> 
> Otherwise:
> 
> Acked-by: Michael Neuling <mikey@neuling.org>

Hey Ben,

These patches have not been applied yet. Would like me to correct
these spellings myself and send out again. Please do let me know. Thanks !

Regards
Anshuman
