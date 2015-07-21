Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2A4C81A01E3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 21:23:24 +1000 (AEST)
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 85ABA140DBC
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 21:23:23 +1000 (AEST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 21 Jul 2015 16:53:20 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 70150E005C
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 16:57:16 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6LBNAGg45220012
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 16:53:11 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6LBN93b031471
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 16:53:09 +0530
Message-ID: <55AE2B97.4070307@linux.vnet.ibm.com>
Date: Tue, 21 Jul 2015 16:53:03 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
CC: mikey@neuling.org
Subject: Re: [RFC,2/8] powerpc/slb: Rename all the 'entry' occurrences to
 'slot'
References: <20150721094606.DBFC7140E10@ozlabs.org>
In-Reply-To: <20150721094606.DBFC7140E10@ozlabs.org>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/21/2015 03:16 PM, Michael Ellerman wrote:
> On Tue, 2015-21-07 at 06:58:40 UTC, Anshuman Khandual wrote:
>> > From: "khandual@linux.vnet.ibm.com" <khandual@linux.vnet.ibm.com>
>> > 
>> > These are essentially SLB individual slots what we are dealing with
>> > in these functions. Usage of both 'entry' and 'slot' synonyms makes
>> > it real confusing sometimes. This patch makes it uniform across the
>> > file by replacing all those 'entry's with 'slot's.
> No I think it would be better the other way around.
> 
> Currently we use entry in 14 places and slot in 3.
> 
> Both can be correct in some places, but not always.
> 
> For example:
> 
>> > -	 * Clear the ESID first so the entry is not valid while we are
>> > +	 * Clear the ESID first so the slot is not valid while we are
> That doesn't make sense with "slot", a slot is not valid, only an entry in a
> slot is valid.
> 
> Looking at the existing uses of slot they will all make sense if you change
> them to entry.

Sure, yeah will do the other way around.
