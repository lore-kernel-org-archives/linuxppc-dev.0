Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrmD83tNszDqKL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 16:38:48 +1000 (AEST)
Message-ID: <1461307125.2646.5.camel@russell.cc>
Subject: Re: [PATCH 3/3] powerpc/eeh: Drop unnecessary label in
 eeh_pe_change_owner()
From: Russell Currey <ruscur@russell.cc>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: alistair@popple.id.au, david@gibson.dropbear.id.au, mpe@ellerman.id.au
Date: Fri, 22 Apr 2016 16:38:45 +1000
In-Reply-To: <1461239595-5627-3-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1461239595-5627-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1461239595-5627-3-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-04-21 at 21:53 +1000, Gavin Shan wrote:
> The label "reset" in eeh_pe_change_owner() is used only for once.
> No need to keep it and just drop it. No logicial changes introduced.

"logicial" should be "logical".  I found something to be pedantic about on each
patch! :)
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---

Reviewed-by: Russell Currey <ruscur@russell.cc>
