Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 599521A06B3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 13:21:30 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 13 Jan 2016 12:21:29 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C5FE53578055
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 13:21:26 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0D2LEiK41025646
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 13:21:26 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0D2KoJO013000
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 13:20:50 +1100
Subject: Re: [PATCH] powerpc/powernv: Fix OPAL_CONSOLE_FLUSH prototype and
 usages
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
References: <1452647072-23321-1-git-send-email-ruscur@russell.cc>
Cc: stewart@linux.vnet.ibm.com
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <5695B468.1080009@au1.ibm.com>
Date: Wed, 13 Jan 2016 13:20:24 +1100
MIME-Version: 1.0
In-Reply-To: <1452647072-23321-1-git-send-email-ruscur@russell.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 13/01/16 12:04, Russell Currey wrote:
> The recently added OPAL API call, OPAL_CONSOLE_FLUSH, originally took no
> parameters and returned nothing.  The call was updated to accept the
> terminal number to flush, and returned various values depending on the
> state of the output buffer.
>
> The prototype has been updated and its usage in the OPAL kmsg dumper has
> been modified to support its new behaviour as an incremental flush.
>
> Signed-off-by: Russell Currey <ruscur@russell.cc>

Looks fine to me.

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
