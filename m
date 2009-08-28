Return-Path: <stuyoder@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BCB07B7B8F
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 29 Aug 2009 04:05:25 +1000 (EST)
Received: from mail-yw0-f171.google.com (mail-yw0-f171.google.com
	[209.85.211.171]) by ozlabs.org (Postfix) with ESMTP id 0A782DDD04
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Aug 2009 04:05:24 +1000 (EST)
Received: by ywh1 with SMTP id 1so2894375ywh.9
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 11:05:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fa686aa40908280906w7953017ek44ee498d57e0a642@mail.gmail.com>
References: <1250569288.19007.15.camel@pasglop>
	<1251346157.20467.22.camel@pasglop> <4A96F69A.5050003@firmworks.com>
	<1251411532.20467.74.camel@pasglop> <4A970C85.8090703@firmworks.com>
	<1251420686.20467.96.camel@pasglop> <4A974295.9020504@firmworks.com>
	<1251427388.20467.122.camel@pasglop>
	<955e48b80908280516m457530cfn3b07b52f2fa2c471@mail.gmail.com>
	<fa686aa40908280906w7953017ek44ee498d57e0a642@mail.gmail.com>
Date: Fri, 28 Aug 2009 13:05:22 -0500
Message-ID: <955e48b80908281105q60c057e8pfc16213f17da9138@mail.gmail.com>
Subject: Re: [RFC] Clock binding
From: Stuart Yoder <stuyoder@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Lets *not* do it on power.org. =A0I'd like to see the bindings used by
> more than just powerpc people, and power.org might become a bit of a
> mental barrier for non-powerpc folks. =A0kernel.org would be a good
> host. =A0So would ozlabs or infradead. =A0Or I'd be happy to maintain one
> on secretlab.

I think broadening it beyond power.org is good.  Along those lines I'd pref=
er
not having this on kernel.org, as device trees are not Linux-centric.  Ther=
e
are other OS vendors I've interacted with that I'd like to see use device t=
rees
and separating it from Linux may be better IMO.

We could also create a new domain like "devicetree.org" (?)..but it still
would nee a host.

Stuart
