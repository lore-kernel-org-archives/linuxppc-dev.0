Return-Path: <John.Linn@xilinx.com>
Received: from VA3EHSOBE002.bigfish.com (va3ehsobe002.messaging.microsoft.com
	[216.32.180.12]) by ozlabs.org (Postfix) with ESMTP id C6A99DDDF9
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Apr 2009 01:54:14 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH] Xilinx : Framebuffer Driver: Add PLB support (non-DCR)
Date: Thu, 9 Apr 2009 09:38:53 -0600
In-Reply-To: <E1LrwIV-0008UK-BS@xyzzy.farnsworth.org>
References: <20090408211521.D0EF411B8054@mail214-sin.bigfish.com><20090409115147.5059493f.sfr@canb.auug.org.au>
	<E1LrwIV-0008UK-BS@xyzzy.farnsworth.org>
From: John Linn <John.Linn@xilinx.com>
To: "Dale Farnsworth" <dale@farnsworth.org>,
	<linuxppc-dev@ozlabs.org>
Message-ID: <20090409153855.1868F14D80AE@mail79-va3.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> -----Original Message-----
> From: Dale Farnsworth [mailto:dale@farnsworth.org] =

> Sent: Thursday, April 09, 2009 9:36 AM
> To: John Linn; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] Xilinx : Framebuffer Driver: Add PLB =

> support (non-DCR)
> =

> > > -----Original Message-----
> > > From: Stephen Rothwell [mailto:sfr@canb.auug.org.au] =

> > > Sent: Wednesday, April 08, 2009 7:52 PM
> > > To: John Linn
> > > Cc: grant.likely@secretlab.ca; jwboyer@linux.vnet.ibm.com; =

> > > linuxppc-dev@ozlabs.org; =

> > > linux-fbdev-devel@lists.sourceforge.net; =

> > > akonovalov@ru.mvista.com; adaplas@gmail.com; Suneel =

> Garapati; Suneel
> > > Subject: Re: [PATCH] Xilinx : Framebuffer Driver: Add PLB =

> > > support (non-DCR)
> > > =

> > > Hi John,
> > > =

> > > On Wed, 8 Apr 2009 15:11:25 -0600 John Linn =

> > > <john.linn@xilinx.com> wrote:
> > > >
> > > >   * 2002-2007 (c) MontaVista Software, Inc.
> > > >   * 2007 (c) Secret Lab Technologies, Ltd.
> > > > + * 2009 (c) Xilinx Inc.
> > > >   *
> > > > - * This file is licensed under the terms of the GNU =

> > > General Public License
> > > > - * version 2.  This program is licensed "as is" without =

> > > any warranty of any
> > > > - * kind, whether express or implied.
> > > > + * This program is free software; you can redistribute it
> > > > + * and/or modify it under the terms of the GNU General Public
> > > > + * License as published by the Free Software Foundation;
> > > > + * either version 2 of the License, or (at your option) any
> > > > + * later version.
> > > > + *
> > > > + * You should have received a copy of the GNU General Public
> > > > + * License along with this program; if not, write to the Free
> > > > + * Software Foundation, Inc., 675 Mass Ave, Cambridge, MA
> > > > + * 02139, USA.
> > > =

> > > This changes the license for this file (from "GPLv2" to "GPLv2 or
> > > later").  Have you asked the other copyright owners about that?
> > =

> > Andrei was copied on the patch, we'll see if he has any =

> thoughts about
> > it. =

> =

> Although I work for MontaVista, I don't speak for them on =

> licensing issues.
> =

> In my opinion, unless someone can come up with a compelling reason
> for changing the license terms of a file, they shouldn't be changed.
> MontaVista made a deliberate, considered decision to license that file
> under GPLv2 and not "GPLv2 or later".  Those who use and distribute
> modifications to GPLv2 licensed work need to respect the license.

Thanks Dale, we agree, Grant said the same thing. I'll fix that when I
respin the patch.

-- John

> =

> -Dale
> =

> =


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
