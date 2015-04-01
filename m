Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0141.hostedemail.com
 [216.40.44.141])
 by lists.ozlabs.org (Postfix) with ESMTP id 1A2F31A2BD8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 03:32:08 +1100 (AEDT)
Message-ID: <1427905921.31790.23.camel@perches.com>
Subject: Re: [PATCH RFC 01/10] devres: add devm_alloc_percpu()
From: Joe Perches <joe@perches.com>
To: madalin.bucur@freescale.com
Date: Wed, 01 Apr 2015 09:32:01 -0700
In-Reply-To: <1427905179-27755-1-git-send-email-madalin.bucur@freescale.com>
References: <1427905179-27755-1-git-send-email-madalin.bucur@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-04-01 at 19:19 +0300, Madalin Bucur wrote:
> Introduce managed counterparts for alloc_percpu() and free_percpu().
> Add devm_alloc_percpu() and devm_free_percpu() into the managed
> interfaces list.

It'd be nice to add include <linux/percpu.h> to these
files rather than get included indirectly via module.h

>  drivers/base/devres.c                 | 63 +++++++++++++++++++++++++++++++++++
>  include/linux/device.h                | 19 +++++++++++
