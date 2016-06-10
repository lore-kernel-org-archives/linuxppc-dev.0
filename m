Return-Path: <oss@buserror.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQlYz756KzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 11:53:11 +1000 (AEST)
Message-ID: <1465523584.22191.127.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com
Date: Thu, 09 Jun 2016 20:53:04 -0500
In-Reply-To: <1465392071-18715-1-git-send-email-mpe@ellerman.id.au>
References: <1465392071-18715-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] powerpc/nohash: Fix build break with 4K pages
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-06-08 at 23:21 +1000, Michael Ellerman wrote:
> Commit 74701d5947a6 "powerpc/mm: Rename function to indicate we are
> allocating fragments" renamed page_table_free() to pte_fragment_free().
> One occurrence was mistyped as pte_fragment_fre().
> 
> This only breaks the nohash 4K page build, which is not the default or
> enabled in any defconfig.

s/4K/64K/

-Scott
