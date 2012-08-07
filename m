Return-Path: <B32616@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 32E642C0040
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2012 13:27:57 +1000 (EST)
From: Liu Qiang-B32616 <B32616@freescale.com>
To: Phillips Kim-R1AAHA <R1AAHA@freescale.com>
Subject: RE: [PATCH v6 0/8] Raid: enable talitos xor offload for improving
 performance
Date: Tue, 7 Aug 2012 03:27:49 +0000
Message-ID: <BCB48C05FCE8BC4D9E61E841ECBE6DB70E108F@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1344247815-1104-1-git-send-email-qiang.liu@freescale.com>
 <20120806203506.bcf31cc63a2d1f55a9695f13@freescale.com>
In-Reply-To: <20120806203506.bcf31cc63a2d1f55a9695f13@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Li Yang-R58472 <r58472@freescale.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "vinod.koul@intel.com" <vinod.koul@intel.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dan.j.williams@gmail.com" <dan.j.williams@gmail.com>,
 "herbert@gondor.hengli.com.au" <herbert@gondor.hengli.com.au>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Phillips Kim-R1AAHA
> Sent: Tuesday, August 07, 2012 9:35 AM
> To: Liu Qiang-B32616
> Cc: linux-crypto@vger.kernel.org; vinod.koul@intel.com;
> dan.j.williams@intel.com; herbert@gondor.hengli.com.au; arnd@arndb.de;
> gregkh@linuxfoundation.org; linuxppc-dev@lists.ozlabs.org; linux-
> kernel@vger.kernel.org; dan.j.williams@gmail.com; Li Yang-R58472
> Subject: Re: [PATCH v6 0/8] Raid: enable talitos xor offload for
> improving performance
>=20
> On Mon, 6 Aug 2012 18:10:15 +0800
> <qiang.liu@freescale.com> wrote:
>=20
> > Changes in v6:
> > 	- swap the order of original patch 3/6 and 4/6;
> > 	- merge Ira's patch to reduce the size of original patch;
> > 	- merge Ira's patch of carma in 8/8;
> > 	- update documents and descriptions according to Ira's advice;
>=20
> fwiw, I gave v5 a test-drive, setting up a RAID5 array on ramdisks [1],
> and this patchseries, along with FSL_DMA && NET_DMA set seems to be
> holding water, so this series gets my:
>=20
> Tested-by: Kim Phillips <kim.phillips@freescale.com>
Thanks, Kim. I will add this line in v7:)

>=20
> Thanks,
>=20
> Kim
>=20
> [1] mdadm --create --verbose --force /dev/md0 --level=3Draid5 --raid-
> devices=3D4 /dev/ram[0123]
