Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 64DAC1A0915
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 10:06:10 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 14 Jan 2016 09:06:08 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E07452BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 10:06:04 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0DN5wsH36503706
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 10:06:06 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0DN5WH0018136
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 10:05:32 +1100
Subject: Re: [PATCH V2] powerpc/powernv: Remove support for p5ioc2
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
References: <1452668681-19458-1-git-send-email-ruscur@russell.cc>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <5696D823.4030307@au1.ibm.com>
Date: Thu, 14 Jan 2016 10:05:07 +1100
MIME-Version: 1.0
In-Reply-To: <1452668681-19458-1-git-send-email-ruscur@russell.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 13/01/16 18:04, Russell Currey wrote:
> "p5ioc2 is used by approximately 2 machines in the world, and has never
> ever been a supported configuration."
>
> The code for p5ioc2 is essentially unused and complicates what is already
> a very complicated codebase.  Its removal is essentially a "free win" in
> the effort to simplify the powernv PCI code.
>
> In addition, support for p5ioc2 has been dropped from skiboot.  There's no
> reason to keep it around in the kernel.
>
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> ---
> V2: Remove pointless union and rebase on -next

Thanks for the changes.

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
