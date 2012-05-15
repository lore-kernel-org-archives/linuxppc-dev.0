Return-Path: <Stefano.Stabellini@eu.citrix.com>
Received: from SMTP.EU.CITRIX.COM (smtp.ctxuk.citrix.com [62.200.22.115])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "*.citrix.com",
 Issuer "VeriSign Class 3 Secure Server CA - G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D13F9B6FAC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2012 20:36:00 +1000 (EST)
Date: Tue, 15 May 2012 11:20:23 +0100
From: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] hvc_xen: NULL dereference on allocation failure
In-Reply-To: <20120515084746.GC30265@elgon.mountain>
Message-ID: <alpine.DEB.2.00.1205151119260.26786@kaball-desktop>
References: <20120515084746.GC30265@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Alan Cox <alan@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 15 May 2012, Dan Carpenter wrote:
> If kzalloc() returns a NULL here, we pass a NULL to
> xencons_disconnect_backend() which will cause an Oops.
> 
> Also I removed the __GFP_ZERO while I was at it since kzalloc() implies
> __GFP_ZERO.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
 
