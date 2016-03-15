Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qPNfq6RxxzDqgc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 16:37:23 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 15 Mar 2016 15:37:21 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 433AE3578052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 16:37:20 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2F5bCMx11534722
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 16:37:20 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2F5alAW011912
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 16:36:47 +1100
Subject: Re: [PATCH] powernv/hmi: Use the "unknown" checkstop type as a
 fallback
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
References: <1458012409-32448-1-git-send-email-ruscur@russell.cc>
 <56E787FE.1060104@au1.ibm.com> <1458018919.30802.4.camel@russell.cc>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <56E79F56.6050006@au1.ibm.com>
Date: Tue, 15 Mar 2016 16:36:22 +1100
MIME-Version: 1.0
In-Reply-To: <1458018919.30802.4.camel@russell.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 15/03/16 16:15, Russell Currey wrote:
>> Would it be useful to print xstop_type in the unknown case?
>
> I don't think so - if there's a new checkstop type, specific handling for
> it should be implemented in the kernel, and if you're getting unknown
> checkstops that are bringing down your machine you should be looking at the
> OPAL firmware log anyway, which would contain details if there was
> something "new".

That's fair, would primarily help debugging in the rather corner case of 
new skiboot, old kernel, and no access to the OPAL log...

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
