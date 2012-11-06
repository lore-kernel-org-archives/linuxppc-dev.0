Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4DDC32C00BF
 for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2012 21:42:36 +1100 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 6 Nov 2012 16:12:32 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qA6AgT4S40697860
 for <linuxppc-dev@ozlabs.org>; Tue, 6 Nov 2012 16:12:29 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qA6AgTxr019018
 for <linuxppc-dev@ozlabs.org>; Tue, 6 Nov 2012 21:42:29 +1100
Message-ID: <5098E9A7.9060200@linux.vnet.ibm.com>
Date: Tue, 06 Nov 2012 16:12:47 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 1/2] powerpc/perf: Fix finding overflowed PMC in interrupt
References: <20121106122559.38ea906f@kryten>
 <1352166835-27980-1-git-send-email-mikey@neuling.org>
 <5098B28B.2070703@linux.vnet.ibm.com> <21513.1352197182@neuling.org>
In-Reply-To: <21513.1352197182@neuling.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/06/2012 03:49 PM, Michael Neuling wrote:
>>
>>
>> I have couple of questions. 
>>
>> Can the buggy overflow happen on any of the available counters PMC1-PMC4 ?
> 
> No.  It's limited to certain events and I believe it can only happen on
> PMC2 and 4.  This code doesn't bother trying to make this distinction
> though.
> 
>> Will this approach never reset an actual user defined event (with
>> sample period < 256) ? Is this related to the counter or the event
>> which it is counting ? Just wondering if we have to do something more
>> than checking for the count < 256. Just a thought.
> 
> 
> I don't understand what you mean by these questions.  Can you explain a
> bit more?
> 

Thats fine. The previous answer explains it well. Thanks !
