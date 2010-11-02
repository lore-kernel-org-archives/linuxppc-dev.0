Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 02551B70E4
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Nov 2010 23:30:22 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: RapidIO: git tree for tracking latest
Date: Tue, 2 Nov 2010 05:30:08 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552014BA084@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <AANLkTi=OCEKVAh1gDYvkeoeSAbiZqyArO6+jdvPuofN6@mail.gmail.com>
References: <AANLkTi=OCEKVAh1gDYvkeoeSAbiZqyArO6+jdvPuofN6@mail.gmail.com>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Thomas Taranowski" <tom@baringforge.com>, <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thomas Taranowski wrote:
> Is there an official maintainer's repository for RapidIO related
> changes to I should be tracking?  I've been tracking Kumar's git
> repository (off kernel.org), but I'm not clear on who the keeper of
> this stuff is.

Currently Andrew Morton's -mm tree has most of RapidIO patches (some of
them moved to 2.6.37-rc1 now). RapidIO patches usually appear in two
mailing lists LKML an this one.
  =20
Alex.
=20
