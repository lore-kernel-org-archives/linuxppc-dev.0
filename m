Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AFEB91A0014
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 16:57:41 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 27 Nov 2015 15:57:41 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 4EB1F2BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 16:57:39 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAR5vVlf27459586
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 16:57:39 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAR5v6Nh022087
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 16:57:07 +1100
Message-ID: <5657F07C.3010008@au1.ibm.com>
Date: Fri, 27 Nov 2015 16:56:12 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
MIME-Version: 1.0
To: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/4] powerpc/powernv: panic() on OPAL < V3
References: <1448599526-31073-1-git-send-email-stewart@linux.vnet.ibm.com>
 <1448599526-31073-2-git-send-email-stewart@linux.vnet.ibm.com>
 <5657EBF5.2030602@au1.ibm.com> <m3lh9km1z5.fsf@oc8180480414.ibm.com>
In-Reply-To: <m3lh9km1z5.fsf@oc8180480414.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 27/11/15 16:43, Stewart Smith wrote:
> Considering you need kernel support for any new POWER processor, and we're not
> about to do an OPALv4 on POWER8 or earlier - we're going to be safe :)

Not a huge problem then :)


-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
