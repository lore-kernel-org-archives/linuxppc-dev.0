Return-Path: <fin@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7E6F12C0090
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Aug 2013 07:55:57 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fin@linux.vnet.ibm.com>;
 Fri, 2 Aug 2013 15:55:55 -0600
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 5EEE538C8027
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Aug 2013 17:55:50 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r72LtpjK124364
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Aug 2013 17:55:51 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r72LtpsD013014
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Aug 2013 17:55:51 -0400
Message-ID: <1375480550.32477.19.camel@what-is-leg>
Subject: Re: [PATCH] drivers/crypto/nx: saves chaining value from co-processor
From: Fionnuala Gunter <fin@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 02 Aug 2013 16:55:50 -0500
In-Reply-To: <1375477741.15999.23.camel@pasglop>
References: <1375477090.32477.10.camel@what-is-leg>
 <1375477741.15999.23.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2013-08-03 at 07:09 +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2013-08-02 at 15:58 -0500, Fionnuala Gunter wrote:
> > The chaining value from co-processor was not being saved. This value is
> > needed because it is used as the IV, for example by cts i.e.
> > cts(cbc(aes)).
> > 
> > Signed-off-by: Fionnuala Gunter <fin@linux.vnet.ibm.com>
> > Signed-off-by: Marcelo Cerri <mhcerri@linux.vnet.ibm.com>
> 
> So now you guys are sending the patch to linuxppc-dev and not the crypto
> list ..
> 
> I need to understand things better here. Any reason why those drivers
> aren't handled by the crypto maintainer ?
> 
> Ben.

Sorry, I thought linuxppc-dev was the right tree since the patch is for
a ppc driver and you've carried previous nx driver submissions
upstream. 

I want to submit to the proper place, so what is your preference?

-Fin
