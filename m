Return-Path: <sprasad@bivio.net>
Received: from corpexc01.corp.networkrobots.com (nofear-snat.bivio.net
	[216.142.75.231]) by ozlabs.org (Postfix) with ESMTP id 687BCDDF56
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Jan 2008 05:32:04 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Control not branching to the instruction present at resetvec	i.e
	0xfffffffc
Date: Wed, 9 Jan 2008 10:28:06 -0800
Message-ID: <D83235F0F3C86D4D889D8B9A0DA8C6D701494050@corpexc01.corp.networkrobots.com>
In-Reply-To: <mailman.1.1199581203.5432.linuxppc-embedded@ozlabs.org>
References: <mailman.1.1199581203.5432.linuxppc-embedded@ozlabs.org>
From: "Siva Prasad" <sprasad@bivio.net>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ravi,

If you already have BDI2000, why don't you single step on it?

Thanks
Siva


Date: Sat, 5 Jan 2008 06:19:05 -0800 (PST)
From: Misbah khan <misbah_khan@engineer.com>
Subject: Re: Control not branching to the instruction present at
	resetvec	i.e 0xfffffffc
To: linuxppc-embedded@ozlabs.org
Message-ID: <14633599.post@talk.nabble.com>
Content-Type: text/plain; charset=3Dus-ascii


Hi Mr Ravi ...
I suggest you to post a new concern in a new thread ....

----Misbah=20

ravi.rao wrote:
>=20
> Hi All,
>     We have a custom target board based on PPC-EP405. We just got the=20
> board from the hardware team .I connected the board to BDI200 and
powered=20
> it on.=20
> The control came to the resetvec address which is 0xfffffffc. I was
able=20
> to read and write to flash. So I erased the flash and burnt the
bootloader=20
> into flash from 0xfffc0000.
> I verified that the instruction at 0xfffffffc is 4bfc2104 whicis
actually=20
> a branch to 0xfffc2100. Also a memory dump of 0xfffc2100 shows the
correct=20
> code. This proved that
> the uboot bootloader was burnt properly.
> Now when I reset the board the control never reaches 0xfffc2100 i.e
for=20
> some reason the code at the resetvec is not getting executed. Any help
or=20
> pointers to resolve this is greatly appreciated.
> Thanks,
> Ravishankar Govindarao
> RFL Electronics Inc.
> E-mail : Ravi.Rao@rflelect.com
> Voice: 973.334.3100 Ext. 233
> Fax: 973.334.3863
> =20
