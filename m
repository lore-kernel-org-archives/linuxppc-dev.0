Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 286702C0092
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 May 2013 14:27:51 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 21 May 2013 01:25:13 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 06141357804A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 May 2013 14:27:42 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4K4DRVn23527546
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 May 2013 14:13:28 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4K4Rewn011340
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 May 2013 14:27:41 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 1/2] powerpc: use smp_rmb when looking at deposisted
 pgtable to store hash index
In-Reply-To: <26735.1369012726@ale.ozlabs.ibm.com>
References: <1368778503-23230-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <26735.1369012726@ale.ozlabs.ibm.com>
Date: Mon, 20 May 2013 09:57:38 +0530
Message-ID: <87vc6e9sxx.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, dwg@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling <mikey@neuling.org> writes:

> Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> wrote:
>
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> We need to use smb_rmb when looking at hpte slot array. Otherwise we could
>> reorder the hpte_slot array load bfore even we marked the pmd trans huge.
>
> Does this need to go back into the stable series?
>

No the changes are not yet upstream. hpte_slot_array changes are in the
THP series. I didn't want to post the entire series again with the 
above two patches. 

-aneesh
