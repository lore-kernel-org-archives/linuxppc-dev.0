Return-Path: <dan.carpenter@oracle.com>
Received: from aserp1050.oracle.com (aserp1050.oracle.com [141.146.126.70])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AAB392C00B2
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Mar 2014 10:04:49 +1100 (EST)
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by aserp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 s27N4lbB013775
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Mar 2014 23:04:47 GMT
Date: Sat, 8 Mar 2014 02:04:21 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: josh@joshtriplett.org
Subject: Re: rfc: checkpatch logical line continuations (was IBM Akebono: Add
 support for a new PHY interface to the IBM emac driver)
Message-ID: <20140307230420.GH29018@mwanda>
References: <1394077948-8395-1-git-send-email-alistair@popple.id.au>
 <1394077948-8395-3-git-send-email-alistair@popple.id.au>
 <20140307.154142.488351276799532264.davem@davemloft.net>
 <1394226164.16156.96.camel@joe-AO722>
 <20140307213017.GA18769@cloud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140307213017.GA18769@cloud>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, devicetree@vger.kernel.org,
 Dan Carpenter <error27@gmail.com>, alistair@popple.id.au,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 07, 2014 at 01:30:17PM -0800, josh@joshtriplett.org wrote:
> On Fri, Mar 07, 2014 at 01:02:44PM -0800, Joe Perches wrote:
> > On Fri, 2014-03-07 at 15:41 -0500, David Miller wrote:
> > > From: Alistair Popple <alistair@popple.id.au>
> > > Date: Thu,  6 Mar 2014 14:52:25 +1100
> > > 
> > > > +	out_be32(dev->reg, in_be32(dev->reg) | WKUP_ETH_RGMIIEN
> > > > +		 | WKUP_ETH_TX_OE | WKUP_ETH_RX_IE);
> > > 
> > > When an expression spans multiple lines, the lines should end with
> > > operators rather than begin with them.
> > 
> > That's not in CodingStyle currently.
> 
> It's also not even remotely consistent across existing kernel code, and
> it isn't obvious that there's a general developer consensus on the
> "right" way to write it.
> 

We just had this discussion in staging and Greg modified the patch to
put the operator at the end.

https://lkml.org/lkml/2014/2/25/125

It's like logical && and || operators which go at the end these days.
I don't really want to have a lot of checkpatch churn to convert
everything...

regards,
dan carpenter
