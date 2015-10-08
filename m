Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4217B1A0143
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Oct 2015 15:18:40 +1100 (AEDT)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 15846140D8C
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2015 15:18:39 +1100 (AEDT)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 8 Oct 2015 14:18:38 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9F2B23578052
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2015 15:18:37 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t984IT4j56361058
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Oct 2015 15:18:37 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t984I584013170
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Oct 2015 15:18:05 +1100
Message-ID: <5615EE7E.9070202@au1.ibm.com>
Date: Thu, 08 Oct 2015 15:18:06 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v2 7/8] powerpc/powernv: Remove pnv_eeh_cap_start()
References: <1444276739-20372-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1444276739-20372-8-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1444276739-20372-8-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/10/15 14:58, Gavin Shan wrote:
> This moves the logic of pnv_eeh_cap_start() to pnv_eeh_find_cap()
> as the function is only called by pnv_eeh_find_cap(). The logic
> of both functions are pretty simple. No need to have separate
> functions.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
