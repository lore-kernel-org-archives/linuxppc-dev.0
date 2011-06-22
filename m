Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6D5A2B6FBA
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Jun 2011 21:44:46 +1000 (EST)
Subject: Re: [PATCH] powerpc/85xx: disable timebase synchronization under the
	hypervisor
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1308105196.2635.16.camel@pasglop>
Date: Wed, 22 Jun 2011 06:44:34 -0500
Message-Id: <083792FF-81CD-407C-B6B8-6D0481A0D65D@kernel.crashing.org>
References: <1308092673-13045-1-git-send-email-timur@freescale.com>
	<20110614181406.294cdf5f@schlenkerla.am.freescale.net>
	<4DF7EB8E.8020308@freescale.com>
	<20110614182517.776d7e77@schlenkerla.am.freescale.net>
	<1308103091.2635.13.camel@pasglop> <4DF814A3.7070209@freescale.com>
	<1308105196.2635.16.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
	Tabi Timur-B04825 <B04825@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"paulus@samba.org" <paulus@samba.org>,
	McClintock Matthew-B29882 <B29882@freescale.com>,
	Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 14, 2011, at 9:33 PM, Benjamin Herrenschmidt wrote:

> On Wed, 2011-06-15 at 02:10 +0000, Tabi Timur-B04825 wrote:
>> Benjamin Herrenschmidt wrote:
>>> We might want to generically have a CPU feature bit indicating we =
are
>>> running in guest vs. HV mode. I know Paulus is planning to introduce =
one
>>> so you may want to sync with him.
>>=20
>> Are you talking about CPU_FTR_HVMODE_206?
>=20
> Well, not exactly. Paul wants to break that up since we're adding some
> primitive support for 201 HV mode too (for 970's). Last we discussed,
> the plan was to go for a generic HV mode bit and a separate bit for =
the
> version.
>=20
> Cheers,
> Ben.

Any ETA on Paul's intro of the FTR bit?  If not I'll pull this into my =
'next' tree and we can clean up later.

- k
