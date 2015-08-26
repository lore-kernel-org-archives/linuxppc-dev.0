Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 914FB1A0E5F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 14:17:07 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Wed, 26 Aug 2015 14:17:06 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 58CD03578052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 14:17:02 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7Q4Grlg56819892
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 14:17:02 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7Q4GTe1031116
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 14:16:29 +1000
Message-ID: <55DD3D83.5020406@linux.vnet.ibm.com>
Date: Wed, 26 Aug 2015 09:46:03 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
CC: j.anaszewski@samsung.com, linux-leds@vger.kernel.org
Subject: Re: [PATCH] powerpc/configs: Enable LEDS support
References: <1440489254-8162-1-git-send-email-hegdevasant@linux.vnet.ibm.com>
 <m3a8teopy3.fsf@oc8180480414.ibm.com>
In-Reply-To: <m3a8teopy3.fsf@oc8180480414.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/26/2015 05:56 AM, Stewart Smith wrote:
> Vasant Hegde <hegdevasant@linux.vnet.ibm.com> writes:
>> Presently PowerNV LEDS driver is specific to FSP based PowerNV
>> platform. Hence added it as 'm'. So that we will be loaded only
>> if we have required device tree support.

Stewart,

> 
> Currently the *firmware* support is FSP specific.
> 
> The driver should magically work on any OPAL machine that hooks up the
> OPAL calls and DT. Right?

Yep. It will just work if we have appropriate device tree . I'll update the
description and resend patch.


> 
> The A in OPAL is for Abstraction, not P for Passthrough-to-fsp.
> 

:-)

-Vasant
