Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0187.outbound.protection.outlook.com [207.46.163.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B96D72C0333
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Feb 2014 08:08:20 +1100 (EST)
Message-ID: <1393016887.6733.871.camel@snotra.buserror.net>
Subject: Re: Question about EHCI on P4080
From: Scott Wood <scottwood@freescale.com>
To: Ruchika <ruchika.k@servergy.com>
Date: Fri, 21 Feb 2014 15:08:07 -0600
In-Reply-To: <53064FC9.8070908@servergy.com>
References: <530598D7.5080602@servergy.com> <53064FC9.8070908@servergy.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-02-20 at 12:56 -0600, Ruchika wrote:
> linuxppc,
> Is there another mailing list which is more appropriate ?
> If so I'd be happy to get a recommendation.

If you're asking about U-Boot support, the list is u-boot@lists.denx.de

Be sure to mention what version of U-Boot you're using, and that you're
using a recent U-Boot.  Also, don't top post or post the same thing
twice.

If you're using U-Boot from the Freescale SDK rather than from upstream,
then instead get support from support@freescale.com or
https://community.freescale.com/  It might be a good idea to go that
route regardless, given that this sounds like it may be a hardware
compatibility issue.

I don't think there is a separate host controller or driver for USB 1.1
(or lower speed USB 2.0) devices on p4080 (though this is common on
PCs).

-Scott

> 
> Thank you
> Regards
> ruchika
> 
> 
> On 2/19/2014 11:55 PM, Ruchika wrote:
> > Hi,
> > I've been trying to understand why the uboot code is unable to work with
> > USB1.1 devices.
> > On a USB analyzer:
> > I notice on an analyzer that there are no SOF or IN tokens seen on the
> > bus at all. The only  after the very first setup packet is sent and ACK'd.
> >
> > The board has a hub chip on it connected to the USB controller via a
> > Ulpi interface.
> >
> > Uboot debug indicates that the transfer times out and was still "Active"
> >
> > The kernel code indicates that a companion driver handles 1.1 devices.
> > Does this mean there are 2 HCD's, one for HS and one for FS/LS in the
> > kernel ?
> > Thank you
> >
> >
> > ruchika
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
> 
