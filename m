Return-Path: <risto.suominen@gmail.com>
Received: from mail-ew0-f45.google.com (mail-ew0-f45.google.com
	[209.85.215.45]) by ozlabs.org (Postfix) with ESMTP id 9B453B708B
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Dec 2010 22:41:08 +1100 (EST)
Received: by ewy10 with SMTP id 10so8564594ewy.18
	for <linuxppc-dev@ozlabs.org>; Tue, 07 Dec 2010 03:41:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1291721424.3607.19.camel@jlt3.sipsolutions.net>
References: <AANLkTinaCDvnOCy1e1Ca92hZO5UuB-9HKe4rvLg7TUEx@mail.gmail.com>
	<1291562178.3495.6.camel@jlt3.sipsolutions.net>
	<AANLkTin-wbJd6qSMnB0GL=mGL_u-cUY00pEHaWo-hpwK@mail.gmail.com>
	<1291717126.3607.17.camel@jlt3.sipsolutions.net>
	<AANLkTik=V0_2_jtQgCnE7jUh_a-Fr+JvcTqUzy1YfLKs@mail.gmail.com>
	<1291721424.3607.19.camel@jlt3.sipsolutions.net>
Date: Tue, 7 Dec 2010 13:41:06 +0200
Message-ID: <AANLkTimG7FLAxPmcXF53VpDS37DrKi=KnKDexF3zEoQ3@mail.gmail.com>
Subject: Re: PowerMac G4 (Digital Audio)
From: Risto Suominen <risto.suominen@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2010/12/7, Johannes Berg <johannes@sipsolutions.net>:
>
> Right, normally we don't need any special handling since the DT has the
> right names ... this machine just needs an override for the GPIO names
> (gpio15/16 rather than the proper detect names).
>
And setting the active-state manually to 1.

Risto
