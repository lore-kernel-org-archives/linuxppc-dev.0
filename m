Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5E4EFB6FD3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2012 12:50:15 +1100 (EST)
Message-ID: <1332381004.2982.65.camel@pasglop>
Subject: Re: [PATCH 14/17] powerpc: crypto: nx driver code supporting nx
 encryption
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <gregkh@linuxfoundation.org>
Date: Thu, 22 Mar 2012 12:50:04 +1100
In-Reply-To: <20120321221517.GB30748@kroah.com>
References: <1332365297.3858.5.camel@key-ThinkPad-W510>
 <1332366068.3858.50.camel@key-ThinkPad-W510>
 <20120321221517.GB30748@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Kent Yoder <key@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, rcj@linux.vnet.ibm.com,
 linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-03-21 at 15:15 -0700, Greg KH wrote:
> 
> Really?  vio drivers are supposed to look like this with the .name and
> .owner field manually being set in the static initialization of the
> driver?  That's sad, and should be fixed, the vio core should do this
> type of thing for you. 

Yeah, they still do it the old way, nobody got to fix that yet, should
be pretty easy though.

Cheers,
Ben.
