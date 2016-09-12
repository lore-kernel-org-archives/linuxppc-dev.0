Return-Path: <colin.king@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXv340W3jzDrp3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 02:51:27 +1000 (AEST)
Subject: Re: [PATCH] powerpc/32: add missing \n at end of printk warning
 message
To: Joe Perches <joe@perches.com>, linuxppc-dev@lists.ozlabs.org
References: <20160912101224.24877-1-colin.king@canonical.com>
 <1473698067.11006.10.camel@perches.com>
Cc: linux-kernel@vger.kernel.org
From: Colin Ian King <colin.king@canonical.com>
Message-ID: <02abdddf-50cc-4aef-398f-51444af5e58a@canonical.com>
Date: Mon, 12 Sep 2016 17:49:55 +0100
MIME-Version: 1.0
In-Reply-To: <1473698067.11006.10.camel@perches.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/09/16 17:34, Joe Perches wrote:
> On Mon, 2016-09-12 at 11:12 +0100, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>> The message is missing a \n, add it.
> 
> Was this found via inspection or a tool?
> 
grep
