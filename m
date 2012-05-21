Return-Path: <konrad.wilk@oracle.com>
Received: from acsinet14.oracle.com (acsinet14.oracle.com [141.146.126.236])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "acsinet14.oracle.com",
 Issuer "VeriSign Class 3 International Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6E47BB6F86
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2012 01:43:32 +1000 (EST)
Received: from acsinet15.oracle.com (acsinet15.oracle.com [141.146.126.227])
 by acsinet14.oracle.com (Sentrion-MTA-4.2.2/Sentrion-MTA-4.2.2) with ESMTP id
 q4LFhTpC000337
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2012 15:43:29 GMT
Date: Mon, 21 May 2012 10:40:53 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Subject: Re: [patch] hvc_xen: NULL dereference on allocation failure
Message-ID: <20120521144053.GA24239@phenom.dumpdata.com>
References: <20120515084746.GC30265@elgon.mountain>
 <alpine.DEB.2.00.1205151119260.26786@kaball-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.00.1205151119260.26786@kaball-desktop>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Dan Carpenter <dan.carpenter@oracle.com>, Alan Cox <alan@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 15, 2012 at 11:20:23AM +0100, Stefano Stabellini wrote:
> On Tue, 15 May 2012, Dan Carpenter wrote:
> > If kzalloc() returns a NULL here, we pass a NULL to
> > xencons_disconnect_backend() which will cause an Oops.
> > 
> > Also I removed the __GFP_ZERO while I was at it since kzalloc() implies
> > __GFP_ZERO.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Acked-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

applied.
>  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
