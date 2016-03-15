Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qPLRy1yDYzDqgl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 14:57:50 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 15 Mar 2016 13:57:48 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id AA1E93578056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 14:57:43 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2F3vZeP46530778
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 14:57:43 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2F3vAYk018059
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 14:57:11 +1100
Subject: Re: [PATCH] powernv/hmi: Use the "unknown" checkstop type as a
 fallback
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
References: <1458012409-32448-1-git-send-email-ruscur@russell.cc>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <56E787FE.1060104@au1.ibm.com>
Date: Tue, 15 Mar 2016 14:56:46 +1100
MIME-Version: 1.0
In-Reply-To: <1458012409-32448-1-git-send-email-ruscur@russell.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 15/03/16 14:26, Russell Currey wrote:
> The HMI code knows about three types of errors: CORE, NX and UNKNOWN.
> If OPAL were to add a new type, it would not be handled at all since
> there is no fallback case.  Instead of explicitly checking for UNKNOWN,
> treat any checkstop type without a handler as unknown.
>
> Signed-off-by: Russell Currey <ruscur@russell.cc>

Indeed it looks like there isn't a fallback case.

Would it be useful to print xstop_type in the unknown case?

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
