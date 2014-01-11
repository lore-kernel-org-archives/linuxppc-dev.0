Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0CC8F2C007E
 for <linuxppc-dev@ozlabs.org>; Sat, 11 Jan 2014 12:06:50 +1100 (EST)
Message-ID: <1389402392.4672.87.camel@pasglop>
Subject: Re: [PATCH 4/8] IBM Akebono: Add support to the OHCI platform
 driver for PPC476GTR
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Date: Sat, 11 Jan 2014 12:06:32 +1100
In-Reply-To: <20140111005256.GB29302@kroah.com>
References: <1385086057-10884-1-git-send-email-alistair@popple.id.au>
 <1385086116-10972-4-git-send-email-alistair@popple.id.au>
 <52D09E19.9030302@cogentembedded.com> <20140111005256.GB29302@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Alistair Popple <alistair@popple.id.au>, linux-usb@vger.kernel.org,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-01-10 at 16:52 -0800, Greg KH wrote:
> > >Signed-off-by: Alistair Popple <alistair@popple.id.au>
> > >Acked-by: Alan Stern <stern@rowland.harvard.edu>
> > >Cc: linux-usb@vger.kernel.org
> > 
> >    Greg, why this patch hasn't been merged? Because it wasn't addressed to
> > you (but BenH)? The other, ehci-platform.c patch didn't even get posted to
> > linux-usb that time, but this one?
> 
> Probably, yes, if it's not sent to me, I'm guessing that the person
> doesn't want it applied by me, especially if it's written by someone who
> knows what they are doing.
> 
> I thought this was going through the PPC tree.  My USB patch queue is
> empty, and closed, for 3.14-rc1.

Communication failure then :-) I told Alistair to submit it to the USB
tree and thus was expecting it to be picked up by you but I didn't pay
that much attention. I'll see if I can still put it into my tree based
on invasiveness when I'm finished with travel. Otherwise, it will wait
for the next window.

Ben.
