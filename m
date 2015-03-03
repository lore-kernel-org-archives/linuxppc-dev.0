Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 30CF01A0244
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Mar 2015 17:10:46 +1100 (AEDT)
Message-ID: <1425363044.20929.0.camel@ellerman.id.au>
Subject: Re: [PATCH 0/3] powerpc/pseries: Fixes and cleanup of
 suspend/migration code
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Tue, 03 Mar 2015 17:10:44 +1100
In-Reply-To: <1425090283-27694-1-git-send-email-tyreld@linux.vnet.ibm.com>
References: <1425090283-27694-1-git-send-email-tyreld@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, cyrilbur@gmail.com, nfont@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-02-27 at 18:24 -0800, Tyrel Datwyler wrote:
> This patchset simplifies the usage of rtas_ibm_suspend_me() by removing an
> extraneous function parameter, fixes device tree updating on little endian
> platforms, and adds a mechanism for informing drmgr that the kernel is cabable of
> performing the whole migration including device tree update itself.
> 
> Tyrel Datwyler (3):
>   powerpc/pseries: Simplify check for suspendability during
>     suspend/migration
>   powerpc/pseries: Little endian fixes for post mobility device tree
>     update
>   powerpc/pseries: Expose post-migration in kernel device tree update
>     to drmgr

Hi Tyrel,

Firstly let me say how much I hate this code, so thanks for working on it :)

But I need you to split this series, into 1) fixes for 4.0 (and stable?), and
2) the rest.

I *think* that would be patch 2, and then patches 1 & 3, but I don't want to
guess. So please resend.

cheers
