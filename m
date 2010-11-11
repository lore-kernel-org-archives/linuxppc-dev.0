Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 66109B7144
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Nov 2010 00:40:51 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 3/4][v2] fsl_rio: move machine_check handler into
	machine_check_e500 & machine_check_e500mc
Date: Thu, 11 Nov 2010 05:40:04 -0800
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E55201538C1E@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <A530CF80-F6B6-40BE-A465-18884B887432@kernel.crashing.org>
References: <1288777018-24259-1-git-send-email-b21989@freescale.com>
	<0CE8B6BE3C4AD74AB97D9D29BD24E55201538B08@CORPEXCH1.na.ads.idt.com>
	<9FCE46230501DF4D9461B9ACC152FD7104DDA26D@zmy16exm20.fsl.freescale.net>
	<A530CF80-F6B6-40BE-A465-18884B887432@kernel.crashing.org>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Kumar Gala" <galak@kernel.crashing.org>,
	"Xie Shaohui-B21989" <B21989@freescale.com>
Cc: Li Yang-R58472 <R58472@freescale.com>, linux-kernel@vger.kernel.org,
	Zang Roy-R61911 <R61911@freescale.com>,
	Gala Kumar-B11780 <B11780@freescale.com>,
	linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala <galak@kernel.crashing.org> wrote:
> > [Xie Shaohui-B21989] Hi Alex, seems your suggestion is some kind of
> > conflict with Kumar, you can have a look at
> > http://patchwork.ozlabs.org/patch/67774/
>=20
> I think Alex's comment is the fact we ignore the 'return' value in the
machine_check_e500 case.

Yes, this one and plus the fact that Mchk exception messages are printed
even if it was handled successfully (by RIO handler). Messages are
printed in both: e500 and e500mc handlers.

Alex.
 =20
