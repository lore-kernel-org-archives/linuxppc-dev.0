Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 by lists.ozlabs.org (Postfix) with ESMTP id D2CC21A0168
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 05:19:38 +1000 (EST)
Date: Tue, 17 Jun 2014 12:23:34 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeff Liu <jeff.liu@oracle.com>
Subject: Re: [PATCH 04/24] powerpc: check/return actual error on sysfs
 functions
Message-ID: <20140617192334.GA4628@kroah.com>
References: <53A0512D.1090909@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53A0512D.1090909@oracle.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 17, 2014 at 10:31:09PM +0800, Jeff Liu wrote:
> From: Jie Liu <jeff.liu@oracle.com>
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Jie Liu <jeff.liu@oracle.com>
> ---
>  arch/powerpc/platforms/powernv/opal-dump.c | 2 +-
>  arch/powerpc/platforms/powernv/opal-elog.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Ben and Paul, please do not take this patch, it is incorrect.

greg k-h
