Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 0A492B6EF1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Oct 2010 04:18:18 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH -mm 0/2] RapidIO: Changes to handling of RIO switches
Date: Tue, 26 Oct 2010 10:17:50 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E5520147D9BA@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <4CC6E43C.8010104@neli.hopto.org>
References: <1287688250-14226-1-git-send-email-alexandre.bounine@idt.com>
	<4CC0AD74.8070800@neli.hopto.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E55201445906@CORPEXCH1.na.ads.idt.com>
	<4CC1D7DE.7060405@neli.hopto.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E55201445A6B@CORPEXCH1.na.ads.idt.com>
	<4CC20923.8050400@neli.hopto.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E55201445BA4@CORPEXCH1.na.ads.idt.com>
	<4CC5ACAB.7070309@neli.hopto.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E5520147D5C2@CORPEXCH1.na.ads.idt.com>
	<4CC5E354.80009@neli.hopto.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E5520147D879@CORPEXCH1.na.ads.idt.com>
	<4CC6E43C.8010104@neli.hopto.org>
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
> In various parts of the enumeration and routing algorithm, it would
need
> to lookup the tag to find the destid, if the destid is in the tag then
> this lookup is not needed.

Let's keep this discussion within limits of the current implementation.
Existing method of forming CT may be replaced when that change is
justified by use.
Any method that may be implemented later is good if it ensures unique
identification of RIO devices. At this moment, we just need to define CT
format now to avoid future conflicts of enumeration methods.

> Well, we both know "the current mainline implementation" is easily
> improved to unique identification I proposed. Therefore this statement
> is misleading.

Your improvement will require assigning separate destID to any switch
that has no endpoints attached. I prefer to keep changes to enumeration
for later patches.

Alex.
