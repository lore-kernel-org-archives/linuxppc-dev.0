Return-Path: <benh@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6534F2C0087
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Dec 2013 08:00:17 +1100 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Fri, 6 Dec 2013 07:00:17 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7C1C33578052
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Dec 2013 08:00:09 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rB5Kg3qj6160676
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Dec 2013 07:42:03 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rB5L08Gd002989
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Dec 2013 08:00:08 +1100
Message-ID: <1386277201.21910.44.camel@pasglop>
Subject: Re: [PATCH -V2 3/5] mm: Move change_prot_numa outside
 CONFIG_ARCH_USES_NUMA_PROT_NONE
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Rik van Riel <riel@redhat.com>
Date: Fri, 06 Dec 2013 08:00:01 +1100
In-Reply-To: <52A0B786.608@redhat.com>
References: <1384766893-10189-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1384766893-10189-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1386126782.16703.137.camel@pasglop> <52A0B786.608@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-12-05 at 12:27 -0500, Rik van Riel wrote:

> However, it appears that since the code was #ifdefed
> like that, the called code was made generic enough,
> that change_prot_numa should actually work for
> everything.
> 
> In other words:
> 
> Reviewed-by: Rik van Riel <riel@redhat.com>

Ok thanks, that's what I needed. Do you have any objection of me merging
that change via the powerpc tree along with the corresponding powerpc
bits from Aneesh ?

The other option would be to have it in a topic branch that I pull from
you.

Cheers,
Ben.
