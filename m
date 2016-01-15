Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CBEFE1A0050
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 12:40:39 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 14 Jan 2016 20:40:36 -0500
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 0845D38C8039
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 20:40:34 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0F1eXCG28966954
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 01:40:33 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0F1a9h6005987
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 20:36:09 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2] powerpc/powernv: Remove support for p5ioc2
In-Reply-To: <1452668681-19458-1-git-send-email-ruscur@russell.cc>
References: <1452668681-19458-1-git-send-email-ruscur@russell.cc>
Date: Fri, 15 Jan 2016 12:40:23 +1100
Message-ID: <878u3raad4.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Russell Currey <ruscur@russell.cc> writes:
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
>
> Tested on a P7IOC machine and a PHB3 machine.
>
> Skiboot p5ioc2 removal patch:
> https://patchwork.ozlabs.org/patch/544898/

Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>

-- 
Stewart Smith
OPAL Architect, IBM.
