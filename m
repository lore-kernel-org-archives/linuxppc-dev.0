Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0170.hostedemail.com
 [216.40.44.170]) by ozlabs.org (Postfix) with ESMTP id 5BA212C00DF
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Mar 2014 10:15:51 +1100 (EST)
Message-ID: <1394234145.16156.109.camel@joe-AO722>
Subject: Re: rfc: checkpatch logical line continuations (was IBM Akebono:
 Add support for a new PHY interface to the IBM emac driver)
From: Joe Perches <joe@perches.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 07 Mar 2014 15:15:45 -0800
In-Reply-To: <20140307230420.GH29018@mwanda>
References: <1394077948-8395-1-git-send-email-alistair@popple.id.au>
 <1394077948-8395-3-git-send-email-alistair@popple.id.au>
 <20140307.154142.488351276799532264.davem@davemloft.net>
 <1394226164.16156.96.camel@joe-AO722> <20140307213017.GA18769@cloud>
 <20140307230420.GH29018@mwanda>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: Randy Dunlap <randy.dunlap@oracle.com>, devicetree@vger.kernel.org,
 Dan Carpenter <error27@gmail.com>, alistair@popple.id.au,
 josh@joshtriplett.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2014-03-08 at 02:04 +0300, Dan Carpenter wrote:
> On Fri, Mar 07, 2014 at 01:30:17PM -0800, josh@joshtriplett.org wrote:
> > On Fri, Mar 07, 2014 at 01:02:44PM -0800, Joe Perches wrote:
> > > On Fri, 2014-03-07 at 15:41 -0500, David Miller wrote:
> > > > From: Alistair Popple <alistair@popple.id.au>
> > > > Date: Thu,  6 Mar 2014 14:52:25 +1100
> > > > 
> > > > > +	out_be32(dev->reg, in_be32(dev->reg) | WKUP_ETH_RGMIIEN
> > > > > +		 | WKUP_ETH_TX_OE | WKUP_ETH_RX_IE);
> > > > 
> > > > When an expression spans multiple lines, the lines should end with
> > > > operators rather than begin with them.
> > > 
> > > That's not in CodingStyle currently.
> > 
> > It's also not even remotely consistent across existing kernel code, and
> > it isn't obvious that there's a general developer consensus on the
> > "right" way to write it.
> > 
> 
> We just had this discussion in staging and Greg modified the patch to
> put the operator at the end.
> 
> https://lkml.org/lkml/2014/2/25/125

I remember and it's the reason I bring it up in a
more public way.

> It's like logical && and || operators which go at the end these days.
> I don't really want to have a lot of checkpatch churn to convert
> everything...

Nor I really.  I simply would like a tool that lets
more core maintainers like David M avoid sending out
"do this, not that" type emails about patches.

I don't mind adding style checking that emits something
for patches and is quieter when scanning files.
