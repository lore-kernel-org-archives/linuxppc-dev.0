Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E43462C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2012 23:58:56 +1000 (EST)
Subject: Re: GE IMP3a
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <50338169.8040102@ge.com>
Date: Tue, 21 Aug 2012 08:58:44 -0500
Message-Id: <D8AFDE1A-73A8-4C7C-817C-CBB95CEDA98B@kernel.crashing.org>
References: <68C39493-C518-4898-954B-CA2E1DCF5DAD@kernel.crashing.org>
 <50338169.8040102@ge.com>
To: Martyn Welch <martyn.welch@ge.com>
Cc: "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 21, 2012, at 7:39 AM, Martyn Welch wrote:

> On 15/08/12 22:32, Kumar Gala wrote:
>> Do you know why ge_imp3a.c has 0x9000 as the 'primary' PCIe bus on =
the board?
>>=20
>=20
> Hi Kumar,
>=20
> Sorry, missed your mail.

np.

> At a quick guess it's because that's the interface that is used for =
the
> on-board PCI devices.

What PCI devices are on-board?

Does the board have any PCIe-ISA bridges?

[ if you can generate an lspci dump, that might answer some of these =
questions ]

thanks

- k=
