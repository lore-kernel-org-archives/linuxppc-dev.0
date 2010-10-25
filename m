Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id AC29BB6F14
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Oct 2010 04:14:38 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH -mm 0/2] RapidIO: Changes to handling of RIO switches
Date: Mon, 25 Oct 2010 10:13:38 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E5520147D5C2@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <4CC5ACAB.7070309@neli.hopto.org>
References: <1287688250-14226-1-git-send-email-alexandre.bounine@idt.com>
	<4CC0AD74.8070800@neli.hopto.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E55201445906@CORPEXCH1.na.ads.idt.com>
	<4CC1D7DE.7060405@neli.hopto.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E55201445A6B@CORPEXCH1.na.ads.idt.com>
	<4CC20923.8050400@neli.hopto.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E55201445BA4@CORPEXCH1.na.ads.idt.com>
	<4CC5ACAB.7070309@neli.hopto.org>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Micha Nelissen" <micha@neli.hopto.org>
Cc: linux-kernel@vger.kernel.org, Thomas Moll <thomas.moll@sysgo.com>,
	akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Micha Nelissen <micha@neli.hopto.org> wrote:
>=20
> Bounine, Alexandre wrote:
> > 1. The destid for the switch needs an additional mechanism to share
it
> > among processors in the RIO network,
>=20
> ? See comment for 2)
>=20
> > 2. It takes ID value away from the pool of available IDs, what will
>=20
> It does not take an ID away, it shares it with a connected endpoint to
> that switch. The tag uses one extra bit to identify the device as a
> switch instead of an endpoint. This provides the information to
> unambiguously identify a switch from an endpoint.

OK taking away #2. But do not see how it justifies storing two values of
destid.

And you have just confirmed using CT for unique identification. We
simply have differences in interpretation of CT: you are using component
tag to pass unique identification and I am using CT as a unique
identification. I prefer not to assume any relationship between routing
information and the component tag.

Alex.
