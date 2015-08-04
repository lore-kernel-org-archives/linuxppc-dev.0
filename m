Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0111.outbound.protection.outlook.com [207.46.100.111])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3CF531A0045
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 06:37:13 +1000 (AEST)
Message-ID: <1438720623.2097.95.camel@freescale.com>
Subject: Re: [v5,RESEND] IFC: Change IO accessor based on endianness
From: Scott Wood <scottwood@freescale.com>
To: Brian Norris <computersforpeace@gmail.com>
CC: <linux-mtd@lists.infradead.org>, <linuxppc-dev@lists.ozlabs.org>,
 Jaiprakash Singh <b44839@freescale.com>
Date: Tue, 4 Aug 2015 15:37:03 -0500
In-Reply-To: <20150528011910.GA16716@home.buserror.net>
References: <1432174631-30091-1-git-send-email-scottwood@freescale.com>
 <20150528011910.GA16716@home.buserror.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-05-27 at 20:19 -0500, Scott Wood wrote:
> On Wed, May 20, 2015 at 09:17:11PM -0500, Scott Wood wrote:
> > From: Jaiprakash Singh <b44839@freescale.com>
> > 
> > IFC IO accressor are set at run time based
> > on IFC IP registers endianness.IFC node in
> > DTS file contains information about
> > endianness.
> > 
> > Signed-off-by: Jaiprakash Singh <b44839@freescale.com>
> > Signed-off-by: Scott Wood <scottwood@freescale.com>
> > ---
> > v5: I'm assuming it's the same as v4, but I didn't send v4, and this
> > comes from a versionless [RESEND] that never made it to the mailing list,
> > so bumping the version just in case.
> > 
> >  .../bindings/memory-controllers/fsl/ifc.txt        |   3 +
> >  drivers/memory/fsl_ifc.c                           |  43 ++--
> >  drivers/mtd/nand/fsl_ifc_nand.c                    | 258 +++++++++++-----
> > -----
> >  include/linux/fsl_ifc.h                            |  50 ++++
> >  4 files changed, 213 insertions(+), 141 deletions(-)
> 
> Brian, can I get an ack for this?

ping

-Scott
