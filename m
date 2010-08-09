Return-Path: <R61911@freescale.com>
Received: from DB3EHSOBE004.bigfish.com (db3ehsobe004.messaging.microsoft.com
	[213.199.154.142]) by ozlabs.org (Postfix) with ESMTP id 3E04BB70A9
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Aug 2010 17:33:42 +1000 (EST)
Received: from mail68-db3 (localhost.localdomain [127.0.0.1])	by
	mail68-db3-R.bigfish.com (Postfix) with ESMTP id AFE3B16D0337	for
	<linuxppc-dev@ozlabs.org>; Mon,  9 Aug 2010 07:33:37 +0000 (UTC)
Received: from DB3EHSMHS003.bigfish.com (unknown [10.3.81.247])	by
	mail68-db3.bigfish.com (Postfix) with ESMTP id 3B00E6A004B	for
	<linuxppc-dev@ozlabs.org>; Mon,  9 Aug 2010 07:33:37 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o797XSVb029699	for
	<linuxppc-dev@ozlabs.org>; Mon, 9 Aug 2010 00:33:33 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o797lIna025276	for <linuxppc-dev@ozlabs.org>;
	Mon, 9 Aug 2010 02:47:19 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH 1/3][MTD] P4080/eLBC: Make Freescale elbc interrupt common
	to elbc devices
Date: Mon, 9 Aug 2010 15:33:22 +0800
Message-ID: <3850A844E6A3854C827AC5C0BEC7B60A03E044@zch01exm23.fsl.freescale.net>
In-Reply-To: <1281063096-26598-1-git-send-email-tie-fei.zang@freescale.com>
From: Zang Roy-R61911 <r61911@freescale.com>
To: "Zang Roy-R61911" <R61911@freescale.com>, <linux-mtd@lists.infradead.org>
Cc: Lan Chunhe-B25806 <B25806@freescale.com>, linuxppc-dev@ozlabs.org,
	akpm@linux-foundation.org, Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Zang Roy-R61911=20
> Sent: Friday, August 06, 2010 10:52 AM
> To: linux-mtd@lists.infradead.org
> Cc: linuxppc-dev@ozlabs.org; akpm@linux-foundation.org; Gala=20
> Kumar-B11780; Lan Chunhe-B25806
> Subject: [PATCH 1/3][MTD] P4080/eLBC: Make Freescale elbc=20
> interrupt common to elbc devices
>=20
> From: Lan Chunhe-B25806 <b25806@freescale.com>
>=20
> Move Freescale elbc interrupt from nand dirver to elbc driver.
> Then all elbc devices can use the interrupt instead of ONLY nand.
>=20
> Signed-off-by: Lan Chunhe-B25806 <b25806@freescale.com>
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> ---
> send the patch to linux-mtd@lists.infradead.org
> it has been posted to linuxppc-dev@ozlabs.org and do not get=20
> any comment.
Any comment about this serial patches?
If none, I'd ask Andrew to merge to his mm tree.
Thanks.
Roy
