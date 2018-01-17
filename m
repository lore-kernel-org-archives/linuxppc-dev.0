Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zM7HZ4G7xzF0bx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 00:30:02 +1100 (AEDT)
In-Reply-To: <151214679127.64022.14518537993458821242.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [V3,
 1/9] powerpc/numa: Look up device node in of_get_assoc_arrays()
Message-Id: <3zM7HY5b19z9sQm@ozlabs.org>
Date: Thu, 18 Jan 2018 00:30:01 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-12-01 at 16:46:35 UTC, Nathan Fontenot wrote:
> Look up the device node for the associativity array property instead
> of having it passed in as a parameter. This changes precedes an update
> in which the calling routines for of_get_assoc_arrays() will not have
> the device node pointer to pass in.
> 
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/35f80debaef07bdaeffbbb20a6e999

cheers
