Return-Path: <david-b@pacbell.net>
Received: from n4-vm0.bullet.mail.gq1.yahoo.com
	(n4-vm0.bullet.mail.gq1.yahoo.com [67.195.9.7])
	by ozlabs.org (Postfix) with SMTP id AD31FB70E5
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Aug 2010 17:14:55 +1000 (EST)
Message-ID: <796604.30863.qm@web180307.mail.gq1.yahoo.com>
Date: Tue, 10 Aug 2010 00:14:54 -0700 (PDT)
From: David Brownell <david-b@pacbell.net>
Subject: Re: [spi-devel-general] [PATCH v2 3/6] mtd: m25p80: add support to
	parse the SPI flash's partitions
To: Mingkai Hu <Mingkai.hu@freescale.com>,
	Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <AANLkTik9cy+at2n28U+Mut4RD6_cJ9uRZzjf+H86d-rp@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com,
	spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=0A=0A--- On Mon, 8/9/10, Grant Likely <grant.likely@secretlab.ca> wrote:=
=0A=0A=0A> > + =A0 =A0 =A0 nr_parts =3D=0A> of_mtd_parse_partitions(&spi->d=
ev, np, &parts);=0A=0ALet's keep OF-specific logic out of drivers like=0Ath=
is one ...  intended to work without OF.=0A=0ANAK on adding dependencies li=
ke OF to drivers=0Aand other infrastructure that starts generic.
