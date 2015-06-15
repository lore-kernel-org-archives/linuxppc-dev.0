Return-Path: <lizefan@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3C1101A0377
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 13:38:49 +1000 (AEST)
Message-ID: <557E4741.70606@huawei.com>
Date: Mon, 15 Jun 2015 11:32:17 +0800
From: Zefan Li <lizefan@huawei.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
CC: <stable@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: stable: Please include commit bb344ca5b90 ("powerpc/mpc85xx:
 Add ranges to etsec2 nodes")
References: <20150326211427.GA20872@home.buserror.net>
In-Reply-To: <20150326211427.GA20872@home.buserror.net>
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2015/3/27 5:14, Scott Wood wrote:
> Commit bb344ca5b90df6 ("powerpc/mpc85xx: Add ranges to etsec2 nodes")
> fixes a bug that was exposed by commit 746c9e9f92dd ("of/base: Fix
> PowerPC address parsing hack").  The latter commit was applied to stable
> trees, so the former should be as well.
> 

Queued up for 3.4. Thanks!
