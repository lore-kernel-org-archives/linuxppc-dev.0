Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 38FAC1A005A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 09:59:37 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 17 Feb 2016 08:59:35 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 161D02BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 09:59:33 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1GMxO4t65405116
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 09:59:33 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1GMx0Ev008583
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 09:59:00 +1100
Date: Wed, 17 Feb 2016 09:58:35 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] MAINTAINERS: rename EEH from "enhanced" to "extended"
 error handling
Message-ID: <20160216225835.GA8240@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1455612720-3758-1-git-send-email-ruscur@russell.cc>
 <20160216224908.GA5078@gwshan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160216224908.GA5078@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 17, 2016 at 09:49:08AM +1100, Gavin Shan wrote:
>On Tue, Feb 16, 2016 at 07:52:00PM +1100, Russell Currey wrote:
>>Incredibly, IBM online documentation for EEH uses "extended error handling"
>>and "enhanced error handling" to refer to the same thing, in different
>>places.  In other parts of the kernel, namely the EEH documentation (found
>>in Documentation/powerpc/eeh-pci-error-recovery.txt), it's referred to as
>>"extended", and in my opinion "extended" makes more sense for what EEH
>>does.
>>
>>The only place "enhanced error handling" shows up in the kernel is in
>>MAINTAINERS, so fix it.
>>
>
>Russell, Thanks for fixing it up. Since you're at it, Please replace the
>maintainer to yourself. Also, the components mentioned in this file are
>listed in alphabetic order according to their names. As the name of EEH
>is changed, it would be put in front of "Extended Verification Module (EVM)".
>

I agree with Michael as discussed in another thread: we're going to use
"enhanced", not "extended" though some chip datasheet (P7IOC) talks about
"extended error handling".

Russell, please change the maintainer to you and repost.

>>Signed-off-by: Russell Currey <ruscur@russell.cc>
>
>With above issues fixed:
>
>Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>

Thanks,
Gavin

>>---
>>I don't know what kind of things parse MAINTAINERS, and if there's a chance
>>this will break them.  Also, the powerpc tree *is* the right place to send
>>this, right?
>>---
>> MAINTAINERS | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>>diff --git a/MAINTAINERS b/MAINTAINERS
>>index 28eb61b..e5d9134 100644
>>--- a/MAINTAINERS
>>+++ b/MAINTAINERS
>>@@ -4222,7 +4222,7 @@ M:	Maxim Levitsky <maximlevitsky@gmail.com>
>> S:	Maintained
>> F:	drivers/media/rc/ene_ir.*
>> 
>>-ENHANCED ERROR HANDLING (EEH)
>>+EXTENDED ERROR HANDLING (EEH)
>> M:	Gavin Shan <shangw@linux.vnet.ibm.com>
>> L:	linuxppc-dev@lists.ozlabs.org
>> S:	Supported
>>-- 
>>2.7.1
>>
>>_______________________________________________
>>Linuxppc-dev mailing list
>>Linuxppc-dev@lists.ozlabs.org
>>https://lists.ozlabs.org/listinfo/linuxppc-dev
>
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@lists.ozlabs.org
>https://lists.ozlabs.org/listinfo/linuxppc-dev
