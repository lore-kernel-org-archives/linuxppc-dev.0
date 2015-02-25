Return-Path: <clg@fr.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 182551A0013
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 08:29:24 +1100 (AEDT)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Wed, 25 Feb 2015 21:29:21 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 476E017D8042
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2015 21:29:35 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1PLTIi76226330
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2015 21:29:18 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1PLTHYc013369
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2015 14:29:18 -0700
Message-ID: <54EE3E93.6070001@fr.ibm.com>
Date: Wed, 25 Feb 2015 22:28:51 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
MIME-Version: 1.0
To: Stewart Smith <stewart@linux.vnet.ibm.com>, mpe@ellerman.id.au
Subject: Re: [PATCH] powerpc/powernv: check OPAL_REGISTER_DUMP_REGION calls
 exist
References: <1424886188-32068-1-git-send-email-clg@fr.ibm.com>
 <m3vbipeloe.fsf@oc8180480414.ibm.com>
In-Reply-To: <m3vbipeloe.fsf@oc8180480414.ibm.com>
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/25/2015 10:16 PM, Stewart Smith wrote:
> Cédric Le Goater <clg@fr.ibm.com> writes:
>> On Open Power systems, such call fails in OPAL : 
>>
>>    OPAL: Called with bad token 101 !
>>
>> The check on the OPAL_UNREGISTER_DUMP_REGION call is added for 
>> symmetry. I did not see any errors for it.
> 
> I've already put in a patch to squash this:
> Message-Id:
> <1423718729-17992-2-git-send-email-stewart@linux.vnet.ibm.com>
> 
> Just waiting on mpe to merge :)

ok fine, I missed it :) 

I am also tempted to fix OPAL_READ_TPO but the proper way to do this 
would be to move the lowlevel OPAL code from drivers/rtc/rtc-opal.c to 
a new file under arch/powerpc/platforms/powernv/. How does that sound ? 

Cheers,

C.
