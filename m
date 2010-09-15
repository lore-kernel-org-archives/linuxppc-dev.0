Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id D5DA5B6EDD
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 04:53:46 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v2 09/10] RapidIO: Add support for IDT CPS Gen2 switches
Date: Wed, 15 Sep 2010 11:52:58 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E5520130332B@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <1682399277683944B902B3657D2FCE216544F4A1F0@CAREXCLUSTER03.ATL.CW.LOCAL>
References: <1284476363-1677-1-git-send-email-alexandre.bounine@idt.com><1284476363-1677-10-git-send-email-alexandre.bounine@idt.com><20100914152049.8d42783f.akpm@linux-foundation.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E5520130321F@CORPEXCH1.na.ads.idt.com>
	<1682399277683944B902B3657D2FCE216544F4A1F0@CAREXCLUSTER03.ATL.CW.LOCAL>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Anderson, Trevor" <tanderson@curtisswright.com>,
	"Andrew Morton" <akpm@linux-foundation.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Thomas Moll <thomas.moll@sysgo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anderson, Trevor <tanderson@curtisswright.com> wrote:
>=20
> Keep it in please. We lurkers in the embedded community do use the
per-port routing tables.
> One of the problems with SRIO switch tables is that access to routes
is not atomic; we can use
> restricted access to per-port routing tables to reduce the risk of
interference. And we still use
> the Global table during enumeration.
>=20
Will it help if I add sysfs attribute(s) to handle per-port routes?
