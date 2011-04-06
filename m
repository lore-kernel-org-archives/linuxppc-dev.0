Return-Path: <Kyle.D.Moffett@boeing.com>
Received: from slb-smtpout-01.boeing.com (slb-smtpout-01.boeing.com
	[130.76.64.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "slb-smtpout-01.boeing.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6935BB6EEB
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Apr 2011 04:42:57 +1000 (EST)
From: "Moffett, Kyle D" <Kyle.D.Moffett@boeing.com>
To: Leon Woestenberg <leon.woestenberg@gmail.com>
Date: Wed, 6 Apr 2011 12:48:27 -0500
Subject: Re: known working sata_sil24.c setup on powerpc platforms?
Message-ID: <C3A1EF35-6CB6-4674-8B0B-44CD1657FE87@boeing.com>
References: <BANLkTimXgi26RHHxyBLoN8YqaDy_PL-hGQ@mail.gmail.com>
In-Reply-To: <BANLkTimXgi26RHHxyBLoN8YqaDy_PL-hGQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Linux PPC <linuxppc-dev@ozlabs.org>, Tejun Heo <htejun@gmail.com>,
	Jeff Garzik <jeff@garzik.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Apr 06, 2011, at 13:00, Leon Woestenberg wrote:
> after investigating problems with sata_sil24.c on a freescale p2020
> soc, I wonder if this driver works on powerpc at all?
>=20
> Does anyone know of a working setup of sata_sil24 on a big endian
> powerpc system?

Our P2020 boards work fine with legacy PCI interrupts (I think it's a sil31=
24 over PCI-E); the only deficiency is that MSI does not seem to work.

I know our MSI *does* work in general because we have an Intel 82571EB chip=
set also attached via PCI-E with working MSI.

Cheers,
Kyle Moffett
