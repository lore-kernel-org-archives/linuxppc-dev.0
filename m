Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wh9pn3SjSzDqLX
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Jun 2017 20:21:53 +1000 (AEST)
In-Reply-To: <20170527154615.29684-1-msuchanek@suse.de>
To: Michal Suchanek <msuchanek@suse.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Michal Suchanek <msuchanek@suse.de>,
 Colin Ian King <colin.king@canonical.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v2] powerpc/fadump: return error when fadump registration fails
Message-Id: <3wh9pn2s7zz9s7M@ozlabs.org>
Date: Mon,  5 Jun 2017 20:21:53 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2017-05-27 at 15:46:15 UTC, Michal Suchanek wrote:
> - log an error message when registration fails and no error code listed
>  in the switch is returned
>  - translate the hv error code to posix error code and return it from
>  fw_register
>  - return the posix error code from fw_register to the process writing
>  to sysfs
>  - return EEXIST on re-registration
>  - return success on deregistration when fadump is not registered
>  - return ENODEV when no memory is reserved for fadump
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/98b8cd7f75643e0a442d7a4c1cef2c

cheers
