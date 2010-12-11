Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id B98F3B6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 12 Dec 2010 05:49:46 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH -mm 4/4] RapidIO: Add new sysfs attributes
Date: Sat, 11 Dec 2010 10:49:33 -0800
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E55201665504@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <20101210152233.3786b432.akpm@linux-foundation.org>
References: <1292013498-31406-1-git-send-email-alexandre.bounine@idt.com><1292013498-31406-5-git-send-email-alexandre.bounine@idt.com>
	<20101210152233.3786b432.akpm@linux-foundation.org>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Andrew Morton" <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Moll <thomas.moll@sysgo.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andrew Morton <akpm@linux-foundation.org> wrote:
>=20
> One would like to see documentation updates along with sysfs API
> updates.  But one fears that this entire interface wasn't documented
> anyway :(

I think I have to find a time for that. I am adding it into my TODO
list.
=20
> Please at least fully describe the proposed interface in the changelog
> so others can review the proposal.

Will do.
=20
> The proposed new sysfs files appear to break the
> one-value-per-sysfs-file rule.

This is true for two of them. I was trying to find a better format for
them and at the end decided to break a rule and use port-device format
for this first version.
I may use just device name but "lnext" has to show multiple devices
anyway.
I decided the one-value-per-sysfs-file rule because it was broken once
already by the "routes" attribute (lprev and lnext have a similar
format).
