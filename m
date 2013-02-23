Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1EFB52C02AB
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Feb 2013 03:18:07 +1100 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 24 Feb 2013 02:13:25 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D8E5D357802D
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Feb 2013 03:18:00 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1NGHw477930296
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Feb 2013 03:17:58 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1NGHxRW024382
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Feb 2013 03:18:00 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC PATCH -V2 03/21] powerpc: Don't hard code the size of pte
 page
In-Reply-To: <20130222050607.GC6139@drongo>
References: <1361465248-10867-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1361465248-10867-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130222050607.GC6139@drongo>
Date: Sat, 23 Feb 2013 21:47:57 +0530
Message-ID: <87621jc8cq.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> writes:

> On Thu, Feb 21, 2013 at 10:17:10PM +0530, Aneesh Kumar K.V wrote:
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> USE PTRS_PER_PTE to indicate the size of pte page.
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> powerpc: Don't hard code the size of pte page
>> 
>> USE PTRS_PER_PTE to indicate the size of pte page.
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>
> Description and signoff are duplicated.  Description could be more
> informative, for example - why would we want to do this?
>
>> +/*
>> + * hidx is in the second half of the page table. We use the
>> + * 8 bytes per each pte entry.
>
> The casual reader probably wouldn't know what "hidx" is.  The comment
> needs at least to use a better name than "hidx".

how about

+/*
+ * We save the slot number & secondary bit in the second half of the
+ * PTE page. We use the 8 bytes per each pte entry.
+ */


-aneesh
