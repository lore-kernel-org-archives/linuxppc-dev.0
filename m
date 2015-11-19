Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0B5841A003D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2015 14:35:28 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 19 Nov 2015 13:35:25 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5627A2CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2015 14:35:23 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAJ3ZGBu34275548
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2015 14:35:24 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAJ3Yo1s008800
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2015 14:34:50 +1100
Message-ID: <564D4342.6050400@au1.ibm.com>
Date: Thu, 19 Nov 2015 14:34:26 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
MIME-Version: 1.0
To: Rashmica Gupta <rashmicy@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Remove unused function trace_syscall()
References: <1447903588-610-1-git-send-email-rashmicy@gmail.com>
In-Reply-To: <1447903588-610-1-git-send-email-rashmicy@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 19/11/15 14:26, Rashmica Gupta wrote:
> This function has been unused since commit 14cf11af6cf6 ("powerpc: Merge enough
> to start building in arch/powerpc."), so remove it.
>
> Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
