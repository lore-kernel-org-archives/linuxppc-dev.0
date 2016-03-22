Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qV8JT405szDq6y
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Mar 2016 10:38:01 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 23 Mar 2016 09:37:59 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id EA2913578057
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Mar 2016 10:37:51 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2MNbhpA4325680
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Mar 2016 10:37:51 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2MNbJwn031210
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Mar 2016 10:37:19 +1100
Subject: Re: [PATCH] arch: powerpc: mm: fixed spelling error.
To: mistryalok <alokn73@gmail.com>, benh@kernel.crashing.org
References: <1458639835-5706-1-git-send-email-alokn73@gmail.com>
Cc: linux-kernel@vger.kernel.org, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, scottwood@freescale.com,
 linuxppc-dev@lists.ozlabs.org
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <56F1D714.3080307@au1.ibm.com>
Date: Wed, 23 Mar 2016 10:36:52 +1100
MIME-Version: 1.0
In-Reply-To: <1458639835-5706-1-git-send-email-alokn73@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Alok

Thanks for wanting to contribute to the Linux kernel!

On 22/03/16 20:43, mistryalok wrote:
> Fixed spelling error.
> Signed-off-by: Alok Mistry <alokn73@gmail.com>
> ---
>   		/*
> -		 * No CPU has hugepages but lacks no execute, so we
> +		 * No CPU has huge pages but lacks no execute, so we
>   		 * don't need to worry about that case
>   		 */

Within the kernel, we have a lot of internal terminology. If you grep 
through the kernel source code, you'll find that in both the 
documentation and the code, we do use the term "hugepage". We also use 
"huge page", but "hugepage" is more common. Therefore I wouldn't call it 
a spelling error, just an internal term :)


Andrew

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
