Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 754F8DDF67
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 07:37:55 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e8.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mBFKWs9H007338
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Dec 2008 15:32:54 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mBFKbp9U152912
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Dec 2008 15:37:51 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mBFKbpgQ003700
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Dec 2008 15:37:51 -0500
Date: Mon, 15 Dec 2008 15:37:44 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: michael@ellerman.id.au
Subject: Re: Need help to understand why kdump is for 64 bit PPC only
Message-ID: <20081215153744.105907e5@zod.rchland.ibm.com>
In-Reply-To: <1229373184.8332.3.camel@localhost>
References: <80872bab0812151058tdffd4b9ucd9031db21c9fc76@mail.gmail.com>
	<1228A590-B809-4EBB-BC6F-05525220656A@kernel.crashing.org>
	<1229373184.8332.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Frank Fan <linuxppcstudy@gmail.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 16 Dec 2008 07:33:04 +1100
Michael Ellerman <michael@ellerman.id.au> wrote:

> On Mon, 2008-12-15 at 13:35 -0600, Kumar Gala wrote:
> > On Dec 15, 2008, at 12:58 PM, Frank Fan wrote:
> >=20
> > > Hello,
> > >
> > > I am working on a freescale MPC8572 CPU board and use 32 bit =20
> > > Linux2.6.28.  When I enable 64 bit, it shows "kdump" in "kernel =20
> > > options". Otherwise, "kdump" is disabled.
> > > Can someone give me some hint why kdump is for 64 bit PPC only?
> >=20
> > Probably because no one has implemented or tested it on ppc32/8572.
>=20
> Pretty much, the 32-bit version of default_machine_kexec() is pretty
> na=C3=AFve, but you never know it might work.

You forgot the obligatory: "Or it could crash and cause your board to
catch on fire."

josh
