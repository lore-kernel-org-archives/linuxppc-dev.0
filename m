Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r06XK4X44zDqCM
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 May 2016 15:48:17 +1000 (AEST)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 4 May 2016 15:17:55 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E13EC357805B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 May 2016 15:17:46 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u445HSv252166828
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 May 2016 15:17:28 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u445GYVl021734
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 May 2016 15:16:35 +1000
Subject: Re: [PATCH] cxl: Remove duplicate #defines
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 mikey <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
References: <1462337312-14010-1-git-send-email-imunsie@au.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <57298567.3010102@au1.ibm.com>
Date: Wed, 4 May 2016 15:15:19 +1000
MIME-Version: 1.0
In-Reply-To: <1462337312-14010-1-git-send-email-imunsie@au.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/05/16 14:48, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
>
> These defines are not used, but other equivalent definitions
> (CXL_SPA_SW_CMD_*) are used. Remove the unused defines.
>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>

They definitely look unused.

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
