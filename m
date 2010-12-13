Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id EAFD6B6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Dec 2010 00:56:21 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH -mm 4/4] RapidIO: Add new sysfs attributes
Date: Mon, 13 Dec 2010 05:55:22 -0800
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E55201665627@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <20101212184834.GA17052@kroah.com>
References: <1292013498-31406-1-git-send-email-alexandre.bounine@idt.com><1292013498-31406-5-git-send-email-alexandre.bounine@idt.com>
	<20101212184834.GA17052@kroah.com>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Greg KH" <greg@kroah.com>
Cc: akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Thomas Moll <thomas.moll@sysgo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Greg KH wrote:
>=20
> Like Andrew pointed out, all sysfs files are required to have entries
in
> Documentation/ABI.  If the existing rapidio sysfs files are not
> documented, please document them in there _before_ adding new ones.
>=20
I included RapidIO documentation update into my plan for next set of
RapidIO patches. Until than this patch may be safely dropped without
affecting other patches in this set.

Alex. =20
