Return-Path: <michel@daenzer.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E7AE9B70D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 19:24:03 +1000 (EST)
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
	by ozlabs.org (Postfix) with ESMTP id 75C92DDD0C
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2009 19:24:03 +1000 (EST)
Subject: Re: Preemption question (4xx related)
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1246486393.14483.14.camel@pasglop>
References: <24271342.post@talk.nabble.com> <1246486393.14483.14.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 02 Jul 2009 11:14:29 +0200
Message-Id: <1246526069.7938.1542.camel@thor>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Felix Radensky <felix@embedded-sol.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-07-02 at 08:13 +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2009-06-30 at 05:55 -0700, Felix Radensky wrote:
> > Hi,
> >=20
> > Preemption is disabled on the vast majority of powerpc
> > targets. Are there any known problems in this area ?
> > I'd like to enable CONFIG_PREEMPT_VOLUNTARY on
> > AMCC 405EX target, to increase application responsiveness.
> > Is it a bad idea ?
>=20
> In theory it should work, but as you may have noticed, it's generally
> disabled and thus not very well tested.
>=20
> It would be a good idea for us, some of the core devs, to turn that on
> in our usual test configs in fact.

FWIW, on my PowerBook I've been running with CONFIG_PREEMPT_VOLUNTARY
enabled for a long time (more than a year). No problems so far, and it
definitely seems to help a lot for interactivity.


--=20
Earthling Michel D=C3=A4nzer           |                http://www.vmware.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
