Return-Path: <jlarrew@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 279C1101737
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2012 16:50:59 +1000 (EST)
Received: from /spool/local
 by e3.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jlarrew@linux.vnet.ibm.com>;
 Thu, 14 Jun 2012 02:50:57 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 0260338C803A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2012 02:50:54 -0400 (EDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5E6oruc229898
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2012 02:50:53 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5E6orMs003015
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2012 00:50:53 -0600
Message-ID: <4FD989CB.4000008@linux.vnet.ibm.com>
Date: Thu, 14 Jun 2012 01:50:51 -0500
From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 5/15] powerpc: convert to %r for all GPR usage
References: <20120608113605.75BD5D43B26@localhost.localdomain>
 <4FD274AF.8080700@linux.vnet.ibm.com> <3125.1339644328@neuling.org>
In-Reply-To: <3125.1339644328@neuling.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/13/2012 10:25 PM, Michael Neuling wrote:

> Jesse Larrew <jlarrew@linux.vnet.ibm.com> wrote:
>> On 06/08/2012 06:36 AM, Michael Neuling wrote:
>>
>>
>>> -/* General Purpose Registers (GPRs) */
>>> +/*
>>> + * General Purpose Registers (GPRs)
>>> + *
>>> + * The lower case r0-r31 should be used in preference to the upper
>>> + * case R0-R31 as they provide more error checking in the assembler.
>>> + * Use R0-31 only when really nessesary.
>>> + */
>>>
<snip>
>>>
>>>  #define	R0	0
>>>  #define	R1	1
>>
>>
>> I think your patch was truncated somehow.
> 
> How so?
> 
> Mikey
> 


Oops. False alarm. I read the comment about the GPRs and expected to see #define statements for R2-31 as well. However, I just realized that your patch didn't actually add them. The R0 and R1 defines are just there for context. My mistake.

Jesse Larrew
Software Engineer, Linux on Power Kernel Team
IBM Linux Technology Center
Phone: (512) 973-2052 (T/L: 363-2052)
jlarrew@linux.vnet.ibm.com
