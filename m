Return-Path: <key@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e1.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ADC4A2C0095
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Sep 2012 03:41:42 +1000 (EST)
Received: from /spool/local
 by e1.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <key@linux.vnet.ibm.com>;
 Fri, 7 Sep 2012 13:41:38 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id AA62938C8041
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Sep 2012 13:37:42 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q87HbfVu21168282
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Sep 2012 13:37:41 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q87HbbBQ019791
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Sep 2012 13:37:39 -0400
Date: Fri, 7 Sep 2012 12:38:09 -0500
From: Kent Yoder <key@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH V3 1/3] drivers/char/tpm: Add new device driver to
 support IBM vTPM
Message-ID: <20120907173809.GA19704@linux.vnet.ibm.com>
References: <1344987282.4430.26.camel@footlong>
 <1345670263.25124.7.camel@footlong>
 <20120822214217.GB13519@linux.vnet.ibm.com>
 <1346816407.2257.37.camel@pasglop>
 <20120905154644.GA14925@linux.vnet.ibm.com>
 <1346879505.19098.3.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1346879505.19098.3.camel@pasglop>
Cc: linux-kernel@vger.kernel.org, Ashley Lai <adlai@linux.vnet.ibm.com>,
 linux-security-module@vger.kernel.org, tpmdd-devel@lists.sourceforge.net,
 adlai@us.ibm.com, James Morris <jmorris@namei.org>, rcj@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> >   James did accept my pull request, so these are already in
> > security-next...
> 
> For the driver itself, it's not a big issue (though I did found issue
> while reviewing it so it will need another round of updates). For the
> code that changes arch/powerpc, especially prom_init.c, that stuff must
> at the very least be acked by me (or the acting powerpc person if I'm
> away) if it's going to go via a different tree.

  Sorry about that.  Hopefully there won't be any changes there and we
can amend with your ack.

  As for the driver updates, I'd hate to see everyone else's code in the
pull request get delayed yet again.  James, will it be ok to apply the
update on top of security-next?

Thanks,
Kent

> Cheers,
> Ben.
> 
