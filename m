Return-Path: <alistair@popple.id.au>
Received: from ipmail07.adl2.internode.on.net (ipmail07.adl2.internode.on.net
 [IPv6:2001:44b8:8060:ff02:300:1:2:7])
 by ozlabs.org (Postfix) with ESMTP id 876502C0084
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Jan 2014 10:54:23 +1100 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/8] IBM Akebono: Add support to the OHCI platform driver
 for PPC476GTR
Date: Mon, 13 Jan 2014 10:54:23 +1100
Message-ID: <8440298.OhsXFXVpzc@mexican>
In-Reply-To: <1389402392.4672.87.camel@pasglop>
References: <1385086057-10884-1-git-send-email-alistair@popple.id.au>
 <20140111005256.GB29302@kroah.com> <1389402392.4672.87.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Greg KH <greg@kroah.com>, linux-usb@vger.kernel.org,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 11 Jan 2014 12:06:32 Benjamin Herrenschmidt wrote:
> On Fri, 2014-01-10 at 16:52 -0800, Greg KH wrote:
> > > >Signed-off-by: Alistair Popple <alistair@popple.id.au>
> > > >Acked-by: Alan Stern <stern@rowland.harvard.edu>
> > > >Cc: linux-usb@vger.kernel.org
> > > >
> > >    Greg, why this patch hasn't been merged? Because it wasn't addressed
> > >    to
> > > 
> > > you (but BenH)? The other, ehci-platform.c patch didn't even get posted
> > > to
> > > linux-usb that time, but this one?
> > 
> > Probably, yes, if it's not sent to me, I'm guessing that the person
> > doesn't want it applied by me, especially if it's written by someone who
> > knows what they are doing.
> > 
> > I thought this was going through the PPC tree.  My USB patch queue is
> > empty, and closed, for 3.14-rc1.
> 
> Communication failure then :-) I told Alistair to submit it to the USB
> tree and thus was expecting it to be picked up by you but I didn't pay
> that much attention. I'll see if I can still put it into my tree based
> on invasiveness when I'm finished with travel. Otherwise, it will wait
> for the next window.

Sorry - this is probably my fault. I originally thought they would go via the 
PPC tree but as Ben said he asked me to resubmit them to the appropriate 
subsystem trees (which I forgot to do). Unless Ben picks them up I will 
resubmit them for the next window.

- Alistair

> Ben.
