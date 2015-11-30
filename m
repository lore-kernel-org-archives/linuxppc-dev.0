Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DE9FD1A08FC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2015 11:21:37 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 30 Nov 2015 10:21:35 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E25AB3578052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2015 11:21:33 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAU0LRuU20447466
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2015 11:21:35 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAU0L1b2016833
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2015 11:21:01 +1100
Message-ID: <565B9654.2010300@au1.ibm.com>
Date: Mon, 30 Nov 2015 11:20:36 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
MIME-Version: 1.0
To: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/4] powerpc/powernv: panic() on OPAL < V3
References: <1448599526-31073-1-git-send-email-stewart@linux.vnet.ibm.com>
 <1448599526-31073-2-git-send-email-stewart@linux.vnet.ibm.com>
 <5657EBF5.2030602@au1.ibm.com>
In-Reply-To: <5657EBF5.2030602@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 27/11/15 16:36, Andrew Donnellan wrote:
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

And withdrawing my Reviewed-by: because apparently I'm not capable of 
spotting missing semicolons, please move the semicolon from patch 2 to 
this patch...


Andrew

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
