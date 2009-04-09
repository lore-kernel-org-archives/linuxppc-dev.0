Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 16611DE144
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Apr 2009 00:30:32 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 9so392703ywe.39
	for <linuxppc-dev@ozlabs.org>; Thu, 09 Apr 2009 07:30:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090409141651.72775AC0056@mail192-sin.bigfish.com>
References: <20090408211521.D0EF411B8054@mail214-sin.bigfish.com>
	<20090409115147.5059493f.sfr@canb.auug.org.au>
	<20090409141651.72775AC0056@mail192-sin.bigfish.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 9 Apr 2009 07:30:15 -0700
Message-ID: <fa686aa40904090730g3d75254cp529ca85c7599ad99@mail.gmail.com>
Subject: Re: [PATCH] Xilinx : Framebuffer Driver: Add PLB support (non-DCR)
To: John Linn <John.Linn@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com,
	Suneel Garapati <suneelg@xilinx.com>, linuxppc-dev@ozlabs.org,
	Suneel <"[mailto:suneel.garapati@xilinx.com]"@xilinx.com>,
	akonovalov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 9, 2009 at 7:16 AM, John Linn <John.Linn@xilinx.com> wrote:
>> -----Original Message-----
>> From: Stephen Rothwell [mailto:sfr@canb.auug.org.au]
>> Sent: Wednesday, April 08, 2009 7:52 PM
>> To: John Linn
>> Cc: grant.likely@secretlab.ca; jwboyer@linux.vnet.ibm.com;
>> linuxppc-dev@ozlabs.org;
>> linux-fbdev-devel@lists.sourceforge.net;
>> akonovalov@ru.mvista.com; adaplas@gmail.com; Suneel Garapati; Suneel
>> Subject: Re: [PATCH] Xilinx : Framebuffer Driver: Add PLB
>> support (non-DCR)
>>
>> Hi John,
>>
>> On Wed, 8 Apr 2009 15:11:25 -0600 John Linn
>> <john.linn@xilinx.com> wrote:
>> >
>> > =A0 * 2002-2007 (c) MontaVista Software, Inc.
>> > =A0 * 2007 (c) Secret Lab Technologies, Ltd.
>> > + * 2009 (c) Xilinx Inc.
>> > =A0 *
>> > - * This file is licensed under the terms of the GNU
>> General Public License
>> > - * version 2. =A0This program is licensed "as is" without
>> any warranty of any
>> > - * kind, whether express or implied.
>> > + * This program is free software; you can redistribute it
>> > + * and/or modify it under the terms of the GNU General Public
>> > + * License as published by the Free Software Foundation;
>> > + * either version 2 of the License, or (at your option) any
>> > + * later version.
>> > + *
>> > + * You should have received a copy of the GNU General Public
>> > + * License along with this program; if not, write to the Free
>> > + * Software Foundation, Inc., 675 Mass Ave, Cambridge, MA
>> > + * 02139, USA.
>>
>> This changes the license for this file (from "GPLv2" to "GPLv2 or
>> later"). =A0Have you asked the other copyright owners about that?
>
> Andrei was copied on the patch, we'll see if he has any thoughts about
> it.

I also hold copyright on this file and I want the license to stay GPLv2.

g.


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
