Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (he.sipsolutions.net [78.46.109.217])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5B164B70A4
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Dec 2010 23:10:03 +1100 (EST)
Subject: Re: PowerMac G4 (Digital Audio)
From: Johannes Berg <johannes@sipsolutions.net>
To: Risto Suominen <risto.suominen@gmail.com>
In-Reply-To: <AANLkTimG7FLAxPmcXF53VpDS37DrKi=KnKDexF3zEoQ3@mail.gmail.com>
References: <AANLkTinaCDvnOCy1e1Ca92hZO5UuB-9HKe4rvLg7TUEx@mail.gmail.com>
	<1291562178.3495.6.camel@jlt3.sipsolutions.net>
	<AANLkTin-wbJd6qSMnB0GL=mGL_u-cUY00pEHaWo-hpwK@mail.gmail.com>
	<1291717126.3607.17.camel@jlt3.sipsolutions.net>
	<AANLkTik=V0_2_jtQgCnE7jUh_a-Fr+JvcTqUzy1YfLKs@mail.gmail.com>
	<1291721424.3607.19.camel@jlt3.sipsolutions.net>
	<AANLkTimG7FLAxPmcXF53VpDS37DrKi=KnKDexF3zEoQ3@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 07 Dec 2010 13:09:58 +0100
Message-ID: <1291723798.3607.45.camel@jlt3.sipsolutions.net>
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

On Tue, 2010-12-07 at 13:41 +0200, Risto Suominen wrote:
> 2010/12/7, Johannes Berg <johannes@sipsolutions.net>:
> >
> > Right, normally we don't need any special handling since the DT has the
> > right names ... this machine just needs an override for the GPIO names
> > (gpio15/16 rather than the proper detect names).
> >
> And setting the active-state manually to 1.

Yes, I guess, it doesn't look like they have the typical property in the
DT for these.

johannes
