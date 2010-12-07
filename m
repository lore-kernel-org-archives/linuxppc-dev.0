Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (he.sipsolutions.net [78.46.109.217])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6643CB70E6
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Dec 2010 21:18:54 +1100 (EST)
Subject: Re: PowerMac G4 (Digital Audio)
From: Johannes Berg <johannes@sipsolutions.net>
To: Risto Suominen <risto.suominen@gmail.com>
In-Reply-To: <AANLkTin-wbJd6qSMnB0GL=mGL_u-cUY00pEHaWo-hpwK@mail.gmail.com>
References: <AANLkTinaCDvnOCy1e1Ca92hZO5UuB-9HKe4rvLg7TUEx@mail.gmail.com>
	<1291562178.3495.6.camel@jlt3.sipsolutions.net>
	<AANLkTin-wbJd6qSMnB0GL=mGL_u-cUY00pEHaWo-hpwK@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 07 Dec 2010 11:18:46 +0100
Message-ID: <1291717126.3607.17.camel@jlt3.sipsolutions.net>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-12-07 at 10:51 +0200, Risto Suominen wrote:
> 2010/12/5, Johannes Berg <johannes@sipsolutions.net>:
> >
> >> http://ristosu.wippiespace.com/pub/alsa-tumbler-1.0.22.1-p15.diff
> >> http://ristosu.wippiespace.com/pub/alsa-tumbler-1.0.22.1-p16.diff
> >
> > These patches are odd -- the first one adds something the second
> > removes? Am I supposed to look at the combination?
> >
> Not really, the second one adds gpio16 but still keeps gpio15.

Oh, so the change to "gpio1" was intended to be some wildcard?

> > But frankly, it's been so long that it's not all making perfect sense to
> > me right now. If you send me a tarball of /proc/device-tree/ maybe I can
> > take a look -- just looked at my collection and I don't have that one.

> A device tree dump

Hmm ok, it's not really making a lot of sense to me now either.

Can you hack the file I previously pointed out and see if that helps?

johannes
