Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2D9142C0097
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2012 00:43:01 +1000 (EST)
Subject: Re: [PATCH v2] PCI: use dev->irq instead of dev->pin to enable non
 MSI/INTx interrupt
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <CAErSpo78VePbVtz1CQrKA5f6tmpU7v_qY6ZYozh9FrW-m0g2rA@mail.gmail.com>
Date: Sun, 9 Sep 2012 09:42:41 -0500
Message-Id: <E01863CB-C76F-4498-8520-BE1817F122BC@kernel.crashing.org>
References: <1342591614-1840-1-git-send-email-Shengzhou.Liu@freescale.com>
 <3F453DDFF675A64A89321A1F35281021771A8B@039-SN1MPN1-003.039d.mgd.msft.net>
 <3E027F8168735B46AC006B1D0C7BB002079D6153@039-SN2MPN1-012.039d.mgd.msft.net>
 <CAErSpo78VePbVtz1CQrKA5f6tmpU7v_qY6ZYozh9FrW-m0g2rA@mail.gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Liu Shengzhou-B36685 <B36685@freescale.com>,
 Wood Scott-B07421 <B07421@freescale.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Zang Roy-R61911 <r61911@freescale.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 7, 2012, at 5:08 PM, Bjorn Helgaas wrote:

> On Mon, Aug 6, 2012 at 8:45 PM, Zang Roy-R61911 <r61911@freescale.com> =
wrote:
>>=20
>>=20
>>> -----Original Message-----
>>> From: Linuxppc-dev [mailto:linuxppc-dev-bounces+tie-
>>> fei.zang=3Dfreescale.com@lists.ozlabs.org] On Behalf Of Liu =
Shengzhou-B36685
>>> Sent: Thursday, July 26, 2012 11:45 AM
>>> To: bhelgaas@google.com; linux-pci@vger.kernel.org; akpm@linux-
>>> foundation.org
>>> Cc: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org; Liu =
Shengzhou-B36685
>>> Subject: RE: [PATCH v2] PCI: use dev->irq instead of dev->pin to =
enable non
>>> MSI/INTx interrupt
>>>=20
>>> Hello,
>>>=20
>>> A gentle reminder!
>>> Any comments are appreciated.
>>=20
>> Who can help to review and pick up this patch?
>=20
> I merged this to a staging branch and will merge it to my "next"
> branch as soon as it gets a build/smoke test by Fengguang.  Thanks!
>=20
> Bjorn

Thanks

- k=
