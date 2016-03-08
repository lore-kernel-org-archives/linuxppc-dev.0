Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B8CF61A0D6B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 19:01:21 +1100 (AEDT)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 88A03140B9A
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2016 19:01:21 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 8 Mar 2016 18:01:19 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 64EE62CE8054
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2016 19:01:17 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u28819Mf36962432
 for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2016 19:01:17 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2880iOs002631
 for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2016 19:00:44 +1100
Subject: Re: [PATCH v3 2/2] cxl: add set/get private data to context struct
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <michaele@au1.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Matt Ochs <mrochs@us.ibm.com>, Manoj Kumar <kumarmn@us.ibm.com>
References: <1457401715-26435-1-git-send-email-imunsie@au.ibm.com>
 <1457401715-26435-2-git-send-email-imunsie@au.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Michael Neuling <mikey@neuling.org>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <56DE8675.5080001@au1.ibm.com>
Date: Tue, 8 Mar 2016 18:59:49 +1100
MIME-Version: 1.0
In-Reply-To: <1457401715-26435-2-git-send-email-imunsie@au.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/03/16 12:48, Ian Munsie wrote:
> From: Michael Neuling <mikey@neuling.org>
>
> This provides AFU drivers a means to associate private data with a cxl
> context. This is particularly intended for make the new callbacks for
> driver specific events easier for AFU drivers to use, as they can easily
> get back to any private data structures they may use.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Reviewed-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>

Looks good to me.

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
