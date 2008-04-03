Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9B3ADDDDE9
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 11:56:29 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m330uQPc011537
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Apr 2008 20:56:26 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m330uQZa192250
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Apr 2008 18:56:26 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m330uQtD026528
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Apr 2008 18:56:26 -0600
Date: Wed, 2 Apr 2008 19:56:00 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3][POWERPC][V2] of_serial: Fix possible null dereference.
Message-ID: <20080402195600.67b2eaf2@zod.rchland.ibm.com>
In-Reply-To: <200804030139.05497.arnd@arndb.de>
References: <20080402165216.8FD2BC9807F@mail21-dub.bigfish.com>
	<fa686aa40804021046n1bc0626ay6a3f9f2a251331ef@mail.gmail.com>
	<200804030139.05497.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 3 Apr 2008 01:39:04 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Wednesday 02 April 2008, Grant Likely wrote:
> > On Wed, Apr 2, 2008 at 10:52 AM, John Linn <john.linn@xilinx.com> wrote:
> > > From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
> > >
> > > =C2=A0The of_serial driver queries the current-speed property and att=
empts
> > > =C2=A0to use it to register the custom_divisor property of the uart_p=
ort.
> > > =C2=A0However, if current-speed is not set, then this code will deref=
erence
> > > =C2=A0a bad pointer. =C2=A0The fix is to only set custom_divisor when=
 a
> > > =C2=A0current-speed property appears in the device tree.
> > >
> > > =C2=A0Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilin=
x.com>
> > > =C2=A0Signed-off-by: John Linn <john.linn@xilinx.com>
> > Acked-by: Grant Likely <grant.likely@secretlab.ca>
>=20
> Acked-by: Arnd Bergmann <arnd@arndb.de>

This is the second time all three of us have Acked this.  I'm pulling
it in my tree.

josh
