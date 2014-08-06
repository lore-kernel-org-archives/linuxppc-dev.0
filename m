Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0142.outbound.protection.outlook.com [207.46.163.142])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E81221A008C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Aug 2014 06:15:56 +1000 (EST)
Message-ID: <1407356142.7427.41.camel@snotra.buserror.net>
Subject: Re: qe: move qe from arch/powerpc to drivers
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang-B45475 <qiang.zhao@freescale.com>
Date: Wed, 6 Aug 2014 15:15:42 -0500
In-Reply-To: <61b449dd79754d25ace3701ccebe10e2@BLUPR03MB341.namprd03.prod.outlook.com>
References: <1403580712-30153-1-git-send-email-B45475@freescale.com>
 <20140730001923.GA4151@home.buserror.net>
 <61b449dd79754d25ace3701ccebe10e2@BLUPR03MB341.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Xie
 Xiaobo-R63061 <X.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-08-06 at 03:53 -0500, Zhao Qiang-B45475 wrote:
> On Wed, Jul 30, 2014 at 08:19 AM, Wood Scott wrote:
> 
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Wednesday, July 30, 2014 8:19 AM
> > To: Zhao Qiang-B45475
> > Cc: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421; Xie Xiaobo-R63061
> > Subject: Re: qe: move qe from arch/powerpc to drivers
> > 
> > On Tue, Jun 24, 2014 at 11:31:52AM +0800, Zhao Qiang wrote:
> > > ls1 has qe and ls1 has arm cpu.
> > > move qe from arch/powerpc to drivers.
> > >
> > > Signed-off-by: Zhao Qiang <B45475@freescale.com>
> > 
> > This is a very terse changelog.  Explain more about what QE is, and what
> > this patch accomplishes (it doesn't seem to get rid of the PPC dependency,
> > just moving code at this stage)
> > 
> > I don't see a MAINTAINERS update for the new path.  Who is going to
> > maintain it?
> > 
> > I don't think drivers/qe is the right place for it.  Directories directly
> > under drivers/ tend to be for classes of devices, not instances.  In any
> > case, LKML should be CCed when creating a new directory directly under
> > drivers/ or under a subdirectory of drivers/ that doesn't have its own
> > mailing list.
> 
> So which directory do you recommend?

drivers/soc/

> Actually qe is a kind of IP block, so in my opinion, it is proper to put it under driver/(just in my opinion).

No, it isn't a type of device (e.g. "ethernet" or "tty").  It's an
abbreviation of a trademark for a specific multipurpose I/O
architecture.

-Scott
