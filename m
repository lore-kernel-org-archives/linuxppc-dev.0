Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 72E4FB6F18
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Oct 2011 13:57:27 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [RFC PATCH 2/2 -mm] RapidIO: TSI721 Add DMA Engine support
Date: Tue, 4 Oct 2011 19:57:19 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552022D635B@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <20111004185718.a5806a7e.akpm00@gmail.com>
References: <1317418715-9666-1-git-send-email-alexandre.bounine@idt.com><1317418715-9666-2-git-send-email-alexandre.bounine@idt.com><20110930151544.31875132.akpm00@gmail.com><0CE8B6BE3C4AD74AB97D9D29BD24E55202291E8D@CORPEXCH1.na.ads.idt.com><20111004144353.18087914.akpm00@gmail.com><0CE8B6BE3C4AD74AB97D9D29BD24E552022D6319@CORPEXCH1.na.ads.idt.com>
	<20111004185718.a5806a7e.akpm00@gmail.com>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: Andrew Morton <akpm00@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andrew Morton wrote:
>=20
> > > No, it can be used all over the place:
> drivers/net/irda/w83977af_ir.c,
> > > drivers/scsi/bnx2fc/bnx2fc_tgt.c,
> > > drivers/net/wireless/rt2x00/rt2x00pci.c,
> > > drivers/crypto/amcc/crypto4xx_core.c and many nmore.
> >
> > In this case I will happily use dma_zalloc_coherent() as soon as
> > it is available
>=20
> geeze, which of us is more lazy?
>=20
> Here we go...
>=20
I have an excuse - I am on vacation. Back to the office in almost two
weeks.
WebMail is the only tool for me right now ;)=20
