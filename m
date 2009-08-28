Return-Path: <imp@bsdimp.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9258CB6EDE
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 29 Aug 2009 04:34:31 +1000 (EST)
Received: from harmony.bsdimp.com (bsdimp.com [199.45.160.85])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BB93DDDD01
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Aug 2009 04:34:30 +1000 (EST)
Date: Fri, 28 Aug 2009 12:23:20 -0600 (MDT)
Message-Id: <20090828.122320.2072670641.imp@bsdimp.com>
To: stuyoder@gmail.com
Subject: Re: [RFC] Clock binding
From: "M. Warner Losh" <imp@bsdimp.com>
In-Reply-To: <955e48b80908281105q60c057e8pfc16213f17da9138@mail.gmail.com>
References: <955e48b80908280516m457530cfn3b07b52f2fa2c471@mail.gmail.com>
	<fa686aa40908280906w7953017ek44ee498d57e0a642@mail.gmail.com>
	<955e48b80908281105q60c057e8pfc16213f17da9138@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In message: <955e48b80908281105q60c057e8pfc16213f17da9138@mail.gmail.co=
m>
            Stuart Yoder <stuyoder@gmail.com> writes:
: > Lets *not* do it on power.org. =A0I'd like to see the bindings used=
 by
: > more than just powerpc people, and power.org might become a bit of =
a
: > mental barrier for non-powerpc folks. =A0kernel.org would be a good=

: > host. =A0So would ozlabs or infradead. =A0Or I'd be happy to mainta=
in one
: > on secretlab.
: =

: I think broadening it beyond power.org is good.  Along those lines I'=
d prefer
: not having this on kernel.org, as device trees are not Linux-centric.=
  There
: are other OS vendors I've interacted with that I'd like to see use de=
vice trees
: and separating it from Linux may be better IMO.

I know of at least one other free OS that will be migrating to device
trees for enumeration of devices in the embedded space...

Warner
