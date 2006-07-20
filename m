Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 6B84D67B97
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jul 2006 16:44:49 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k6K82Rfp000917
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jul 2006 02:02:27 -0600 (MDT)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k6K6iiu3006055
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jul 2006 01:44:46 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [linux-usb-devel] [PATCH] Add USB to MPC8349 PB platform support
Date: Thu, 20 Jul 2006 14:45:05 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D0705B8@zch01exm20.fsl.freescale.net>
In-Reply-To: <20060719121922.ef989b1d.zaitcev@redhat.com>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Pete Zaitcev" <zaitcev@redhat.com>
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Pete Zaitcev [mailto:zaitcev@redhat.com]
> Sent: Thursday, July 20, 2006 3:19 AM
> To: Li Yang-r58472
> Cc: dan@embeddedalley.com; linuxppc-dev@ozlabs.org;
galak@kernel.crashing.org;
> linux-usb-devel@lists.sourceforge.net; zaitcev@redhat.com
> Subject: Re: [linux-usb-devel] [PATCH] Add USB to MPC8349 PB platform
support
>=20
> On Thu, 20 Jul 2006 02:59:44 +0800, "Li Yang" <LeoLi@freescale.com>
wrote:
>=20
> > But why?  Most embedded products facing end-user wouldn't like users
> > to modify the system by themselves.
>=20
> Certainly vendors won't like to give consumers extra freedoms.
> However, consumers like those freedoms, even if they would not
> use them in any specific instance.
>=20
> >  Sometimes they even put effort in preventing user to do so.
>=20
> Jerks and criminals, that's what they are. Why would Linux developers
> care about needs of these people?
>=20
> Free software is about protecting the rights of users against
> vendors who "wouldn't like" users doing what they want with the
> product they bought.
>=20
> > The only kind of products I can think of, which
> > want the users to modify the code is reference boards, IMHO.
>=20
> Ever heard of WRT54? But in fact, every product out there may provide
> its owner an additional value when customized. I'd love to fix some
> bugs in my microwave, for instance. The silly thing will not start
> the timer if the door is open. It probably uses the same function
> which prevents cooking from starting (it also has a hardware interlock
> that cuts the magnetron, but this is different).

You are right.  We really need to stick up for the freedom of software
as Richard Stallman advocated.  :) However, I was talking about code
that goes into public kernel source tree.  It's ok to distribute the
code with CD or web link.  But if the code is not generic enough or
can't be reused, it won't qualify to be included in mainstream kernel
tree, I think.

-- Leo
