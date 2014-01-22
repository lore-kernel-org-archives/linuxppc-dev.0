Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0236.outbound.protection.outlook.com [207.46.163.236])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 71A952C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jan 2014 07:33:26 +1100 (EST)
Message-ID: <1390422794.24905.510.camel@snotra.buserror.net>
Subject: Re: [PATCH RFC] powerpc/mpc85xx: add support for the kmp204x
 reference board
From: Scott Wood <scottwood@freescale.com>
To: Valentin Longchamp <valentin.longchamp@keymile.com>
Date: Wed, 22 Jan 2014 14:33:14 -0600
In-Reply-To: <52DFF413.7060806@keymile.com>
References: <1389879525-27130-1-git-send-email-valentin.longchamp@keymile.com>
 <1389915301.24905.240.camel@snotra.buserror.net>
 <52D9273E.10008@keymile.com>
 <1389995322.24905.275.camel@snotra.buserror.net>
 <52DD50F7.1050107@keymile.com>
 <1390257432.24905.329.camel@snotra.buserror.net>
 <52DEA179.9090607@keymile.com>
 <1390323689.24905.484.camel@snotra.buserror.net>
 <52DFF413.7060806@keymile.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-01-22 at 17:38 +0100, Valentin Longchamp wrote:
> On 01/21/2014 06:01 PM, Scott Wood wrote:
> > On Tue, 2014-01-21 at 17:34 +0100, Valentin Longchamp wrote:
> >> Can you please explicitly tell me how I should build this node ? What other
> >> comments ? Must I be more generic with the name ?
> >>
> >> Something like :
> >>
> >> spi@1 {
> >> 	compatible = "zarlink,30343", "spidev";
> > 
> > Remove "spidev".  Any nodes under the SPI controller node will be SPI
> > devices, right?  So it doesn't add anything regarding hardware
> > description.
> >  
> 
> OK.
> 
> Thank you for the feedback, I will then send a revised patch as soon as I have time.

Oh, and ideally the node name should describe the function of the device
-- "spi" as a node name usually means a SPI controller.

Maybe "ptp_clock@1"?

Also, zarlink should be added to
Documentation/devicetree/bindings/vendor-prefixes.txt

-Scott
