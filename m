Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe002.messaging.microsoft.com
	[213.199.154.140])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 80959B70F4
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Nov 2010 05:46:01 +1100 (EST)
Received: from mail13-db3 (localhost.localdomain [127.0.0.1])	by
	mail13-db3-R.bigfish.com (Postfix) with ESMTP id DDD68BA018A	for
	<linuxppc-dev@ozlabs.org>; Mon, 22 Nov 2010 18:45:56 +0000 (UTC)
Received: from DB3EHSMHS011.bigfish.com (unknown [10.3.81.242])	by
	mail13-db3.bigfish.com (Postfix) with ESMTP id BC17D590050	for
	<linuxppc-dev@ozlabs.org>; Mon, 22 Nov 2010 18:45:56 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	oAMIjfYj003501	for
	<linuxppc-dev@ozlabs.org>; Mon, 22 Nov 2010 11:45:52 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	oAMJ3MCu012663	for <linuxppc-dev@ozlabs.org>;
	Mon, 22 Nov 2010 13:03:22 -0600 (CST)
Date: Mon, 22 Nov 2010 12:45:39 -0600
From: Scott Wood <scottwood@freescale.com>
To: <michael@ellerman.id.au>
Subject: Re: [git pull] Please pull powerpc.git merge branch
Message-ID: <20101122124539.190584d8@udp111988uds.am.freescale.net>
In-Reply-To: <1290145458.2867.3.camel@concordia>
References: <1290059208.32570.3.camel@pasglop> <30983.1290116555@neuling.org>
	<1290118082.29105.11.camel@concordia>
	<20101119163104.624d264d.sfr@canb.auug.org.au>
	<1290145458.2867.3.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 19 Nov 2010 16:44:18 +1100
Michael Ellerman <michael@ellerman.id.au> wrote:

> On Fri, 2010-11-19 at 16:31 +1100, Stephen Rothwell wrote:
> > On Fri, 19 Nov 2010 09:08:02 +1100 Michael Ellerman <michael@ellerman.i=
d.au> wrote:
> > >
> > > I vote for:
> > >=20
> > >  -> Exception: 401 (Instruction Access) at 00000000f7937794
> >=20
> > Or:
> >=20
> > =E2=98=9B Exception: 401 (Instruction Access) at 00000000f7937794
>=20
> Let's get serious, it's _really_ like a phone call:
>=20
> =E2=98=8E Exception: 401 (Instruction Access) at 00000000f7937794

Sparc got it right:

void die_if_kernel(char *str, struct pt_regs *regs)
{
	static int die_counter;
	int count =3D 0;
=09
	/* Amuse the user. */
	printk(
"              \\|/ ____ \\|/\n"
"              \"@'/ .. \\`@\"\n"
"              /_| \\__/ |_\\\n"
"                 \\__U_/\n");

-Scott
