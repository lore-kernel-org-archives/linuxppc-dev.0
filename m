Return-Path: <shawnxjin@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.200])
	by ozlabs.org (Postfix) with ESMTP id 174A967EE1
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 13 Aug 2005 07:28:32 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 68so642607wra
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Aug 2005 14:28:31 -0700 (PDT)
Message-ID: <c3d0340b05081214282adeda4c@mail.gmail.com>
Date: Fri, 12 Aug 2005 14:28:30 -0700
From: Shawn Jin <shawnxjin@gmail.com>
To: ppcembed <linuxppc-embedded@ozlabs.org>
In-Reply-To: <20050811231710.GB5796@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <c3d0340b050811154148164691@mail.gmail.com>
	<20050811231454.GA5796@gate.ebshome.net>
	<20050811231710.GB5796@gate.ebshome.net>
Subject: Re: What's wrong with the serial port?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/11/05, Eugene Surovegin <ebs@ebshome.net> wrote:
> On Thu, Aug 11, 2005 at 04:14:54PM -0700, Eugene Surovegin wrote:
> > > MMU:exit
> > > setup_arch: enter
> > > setup_arch: bootmem
> > > arch: exit
> > > ??????
> >
> > Try disabling early text debugging (all that "MMU:..." stuff).
> >
>=20
> Also, make sure you pass correct "console=3D..." line to the kernel
> (with correct device name and baud rate).

After early text debugging is disabled and the correct "console=3DttyS0,
115200" option is passed to kernel, the problem still exists. Also I'm
sure the divisor set to UART is also correct because they are the same
values when U-Boot sets up the port.

Has the serial port enabled interrupt so far at this stage?

Thanks,
-Shawn.
