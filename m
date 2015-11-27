Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E87F81A0014
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 16:47:24 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 27 Nov 2015 15:47:24 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 6AF512BB003F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 16:47:21 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAR5lERj12976314
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 16:47:22 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAR5km2h013221
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 16:46:49 +1100
Message-ID: <5657EE12.7080905@au1.ibm.com>
Date: Fri, 27 Nov 2015 16:45:54 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
MIME-Version: 1.0
To: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/4] powerpc/powernv: remove FW_FEATURE_OPAL and just
 use FW_FEATURE_OPALv3
References: <1448599526-31073-1-git-send-email-stewart@linux.vnet.ibm.com>
 <1448599526-31073-4-git-send-email-stewart@linux.vnet.ibm.com>
In-Reply-To: <1448599526-31073-4-git-send-email-stewart@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 27/11/15 15:45, Stewart Smith wrote:
> Long ago, only in the lab, there was OPALv1 and OPALv2. Now there is
> just OPALv3, with nobody ever expecting anything on pre-OPALv3 to
> be cared about or supported by mainline kernels.
>
> So, let's remove FW_FEATURE_OPAL and instead use FW_FEATURE_OPALv3
> exclusively.
>
> Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>

I haven't checked for any outstanding references you've missed here, but 
I'm going to assume it compiles...

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
