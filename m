Return-Path: <R61911@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) by ozlabs.org (Postfix) with ESMTP id 3FDA5B70F7
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Sep 2010 20:33:50 +1000 (EST)
Received: from mail155-tx2 (localhost.localdomain [127.0.0.1])	by
	mail155-tx2-R.bigfish.com (Postfix) with ESMTP id 302F23E03DA	for
	<linuxppc-dev@ozlabs.org>; Fri,  3 Sep 2010 10:33:44 +0000 (UTC)
Received: from TX2EHSMHS043.bigfish.com (unknown [10.9.14.243])	by
	mail155-tx2.bigfish.com (Postfix) with ESMTP id 029C5C4804C	for
	<linuxppc-dev@ozlabs.org>; Fri,  3 Sep 2010 10:33:44 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o83AXTXK027350	for <linuxppc-dev@ozlabs.org>;
	Fri, 3 Sep 2010 03:33:40 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP
	id o83AjgaH012543	for <linuxppc-dev@ozlabs.org>;
	Fri, 3 Sep 2010 05:45:43 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH 1/3][MTD] P4080/eLBC: Make Freescale elbc interrupt common
	to elbc devices
Date: Fri, 3 Sep 2010 18:33:27 +0800
Message-ID: <3850A844E6A3854C827AC5C0BEC7B60A1B36A4@zch01exm23.fsl.freescale.net>
In-Reply-To: <1281063096-26598-1-git-send-email-tie-fei.zang@freescale.com>
References: <1281063096-26598-1-git-send-email-tie-fei.zang@freescale.com>
From: Zang Roy-R61911 <r61911@freescale.com>
To: "Zang Roy-R61911" <R61911@freescale.com>, <linux-mtd@lists.infradead.org>,
	"Gala Kumar-B11780" <B11780@freescale.com>
Cc: Lan Chunhe-B25806 <B25806@freescale.com>, linuxppc-dev@ozlabs.org,
	akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Zang Roy-R61911
> Sent: Friday, August 06, 2010 10:52 AM
> To: linux-mtd@lists.infradead.org
> Cc: linuxppc-dev@ozlabs.org; akpm@linux-foundation.org; Gala
Kumar-B11780; Lan
> Chunhe-B25806
> Subject: [PATCH 1/3][MTD] P4080/eLBC: Make Freescale elbc interrupt
common to
> elbc devices
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
> it has been posted to linuxppc-dev@ozlabs.org and do not get any
comment.

Hi, Kumar

I can see that this patch delegates to you in the mail list.
Do you have any comment?
Today, I rebase the patch to Linux 2.6.26-rc3.
1/3, 3/3 are still OK for the latest tree.
For patch 2/3, some minor fix needs to change for of_dev to
platform_device.

Should I resend the patch?
Thanks.
Roy
