Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 167E52C0346
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Jun 2013 14:15:53 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 28 Jun 2013 14:06:08 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 681B73578045
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Jun 2013 14:15:47 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5S40sq46226422
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Jun 2013 14:00:54 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5S4FiWj004852
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Jun 2013 14:15:46 +1000
Message-ID: <51CD0DC7.7020702@linux.vnet.ibm.com>
Date: Fri, 28 Jun 2013 09:45:03 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 8/8] powerpc/perf: Add power8 EBB support
References: <1372073336-8189-1-git-send-email-michael@ellerman.id.au>
 <1372073336-8189-8-git-send-email-michael@ellerman.id.au>
 <51CABB56.9010105@linux.vnet.ibm.com> <1372333965.29229.26.camel@concordia>
In-Reply-To: <1372333965.29229.26.camel@concordia>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, sukadev@linux.vnet.ibm.com,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/27/2013 05:22 PM, Michael Ellerman wrote:
> 
> On Wed, 2013-06-26 at 15:28 +0530, Anshuman Khandual wrote:
>>> @@ -117,6 +117,7 @@
>>>  	 (EVENT_UNIT_MASK      << EVENT_UNIT_SHIFT)		|	\
>>>  	 (EVENT_COMBINE_MASK   << EVENT_COMBINE_SHIFT)		|	\
>>>  	 (EVENT_MARKED_MASK    << EVENT_MARKED_SHIFT)		|	\
>>> +	 (1ull		       << EVENT_CONFIG_EBB_SHIFT)	|	\
>>
>> We should define this macro like EVENT_MARKED_MASK
>>
>> #define EVENT_EBB_MASK       0x1
>>
>> Numeric value of "1ull" stands out odd in the scheme.
> 
> Yeah I guess.
> 
> Would you like it in blue? :)
> 

:) No, I meant probably a macro definition would be cool.
