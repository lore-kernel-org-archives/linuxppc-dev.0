Return-Path: <Leonid@a-k-a.net>
Received: from mis011-1.exch011.intermedia.net
	(mis011-1.exch011.intermedia.net [64.78.21.128])
	by ozlabs.org (Postfix) with ESMTP id 5CCE9DDDF6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Jan 2008 12:35:32 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: USB device for ppc440epx
Date: Wed, 23 Jan 2008 17:34:33 -0800
Message-ID: <406A31B117F2734987636D6CCC93EE3C02CEE295@ehost011-3.exch011.intermedia.net>
In-reply-to: <20080123192003.03f4fa0b@zod.rchland.ibm.com>
References: <BAY115-W17ECE16AB6FA79B2D4DBBDB23D0@phx.gbl><440abda90801202354l5a0ce4caq382af5991e36f775@mail.gmail.com><BAY115-W344A18C61627B3075C6281B23D0@phx.gbl><EDAE140DF1B2FC42B5867C22CA0B333F0A5952@XMBIL132.northgrum.com><BAY115-W415137ADEA0BE4A33D2BAEB23F0@phx.gbl><EDAE140DF1B2FC42B5867C22CA0B333F0A5959@XMBIL132.northgrum.com><BAY115-W393608FBCB3E1070428538B23F0@phx.gbl><20080123193557.AF0C8670018@mail194-sin.bigfish.com><406A31B117F2734987636D6CCC93EE3C02CEE287@ehost011-3.exch011.intermedia.net>
	<20080123192003.03f4fa0b@zod.rchland.ibm.com>
From: "Leonid" <Leonid@a-k-a.net>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, Josh:

Ooops, I didn't notice I have hijacked someone's thread, I thought I
created a new one. I am very sorry if I have done so, I'll be more
careful.

Regarding USB Mass Storage there are device drivers (Host side) of
course. However I am asking regarding USB device implementation itself.
Can you point me to source files where this implementation is present
for 440ep/epx?

Linux has several examples of devices (like Zero Gadget) and I have used
it with ARM CPUs. But I am not sure it is working on 440epx also.

Thanks,

Leonid.=20

-----Original Message-----
From: Josh Boyer [mailto:jwboyer@linux.vnet.ibm.com]=20
Sent: Wednesday, January 23, 2008 5:20 PM
To: Leonid
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: USB device for ppc440epx

On Wed, 23 Jan 2008 17:01:02 -0800
"Leonid" <Leonid@a-k-a.net> wrote:

> Hi:
>=20
> does somebody have code example for USB 2.0 device implementation for=20
> ppc440epx, preferably Mass Storage device, but any will do.
>=20
> If not for ppc440epx (Sequoia board), ppc440ep (Yosemite) code will=20
> also help (according to CPU user manual USB device interface is=20
> practically the same).
>=20
> If this is already present in Linux kernel tree (from what version?),=20
> where it is located?

USB mass storage works on 440EP already.  It'll be in 2.6.25 in
arch/powerpc.  I would suspect 440EPx works as well.

BTW, it's considered impolite to hijack a thread to ask a completely
unrelated question.

josh
