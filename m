Return-Path: <John.Linn@xilinx.com>
Received: from mail107-sin-R.bigfish.com (mail-sin.bigfish.com [207.46.51.74])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0F05EDDF14
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 06:36:44 +1000 (EST)
Received: from mail107-sin (localhost.localdomain [127.0.0.1])
	by mail107-sin-R.bigfish.com (Postfix) with ESMTP id CCCF313B01BC
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 20:36:40 +0000 (UTC)
Received: from xsj-gw1 (unknown [149.199.60.83])
	by mail107-sin.bigfish.com (Postfix) with ESMTP id DAD3E48804F
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 20:36:39 +0000 (UTC)
Received: from unknown-38-66.xilinx.com ([149.199.38.66]
	helo=xsj-smtp1.xilinx.com) by xsj-gw1 with esmtp (Exim 4.63)
	(envelope-from <John.Linn@xilinx.com>) id 1K94OV-0005Ut-4O
	for linuxppc-dev@ozlabs.org; Wed, 18 Jun 2008 13:36:39 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: 44x defconfig directory
Date: Wed, 18 Jun 2008 14:36:37 -0600
In-Reply-To: <47ecccf53807a949b54dede883137c6d@kernel.crashing.org>
References: <1207487181.6809.18.camel@vader.jdub.homelinux.org><73BD1263-F09B-4E08-AA77-BEBD67D91C58@kernel.crashing.org><1207709608.3996.0.camel@vader.jdub.homelinux.org><18428.24729.933714.665889@cargo.ozlabs.ibm.com>
	<47ecccf53807a949b54dede883137c6d@kernel.crashing.org>
From: "John Linn" <John.Linn@xilinx.com>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <20080618203639.DAD3E48804F@mail107-sin.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I'm adding a new defconfig file to the new configs/44x directory and
make doesn't seem to find it.

I must be missing something as this seems simple.

Should I have to specify 44x in the path (make ARCH=3Dpowerpc
44x/defconfig) as this does work?

Thanks,
John

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
