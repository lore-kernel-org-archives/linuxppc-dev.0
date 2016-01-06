Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 99DA01A1766
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jan 2016 13:09:58 +1100 (AEDT)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6CDD4140297
 for <linuxppc-dev@ozlabs.org>; Wed,  6 Jan 2016 13:09:58 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 6 Jan 2016 12:09:57 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id B21292CE8054
 for <linuxppc-dev@ozlabs.org>; Wed,  6 Jan 2016 13:09:48 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0629JIH37748990
 for <linuxppc-dev@ozlabs.org>; Wed, 6 Jan 2016 13:09:27 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0629F2V019307
 for <linuxppc-dev@ozlabs.org>; Wed, 6 Jan 2016 13:09:16 +1100
Subject: Re: [PATCH 1/2] powerpc: sparse: static-ify some things
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
References: <1452041151-2387-1-git-send-email-dja@axtens.net>
Cc: mikey@neuling.org
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <568C7732.5020505@au1.ibm.com>
Date: Wed, 6 Jan 2016 13:08:50 +1100
MIME-Version: 1.0
In-Reply-To: <1452041151-2387-1-git-send-email-dja@axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/01/16 11:45, Daniel Axtens wrote:
> As sparse suggests, these should be made static.
>
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
