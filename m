Return-Path: <John.Linn@xilinx.com>
Received: from SG2EHSOBE005.bigfish.com (sg2ehsobe005.messaging.microsoft.com
	[207.46.51.79]) by ozlabs.org (Postfix) with ESMTP id 50B04B7D06
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Feb 2010 12:57:35 +1100 (EST)
Received: from mail13-sin (localhost [127.0.0.1])	by mail13-sin-R.bigfish.com
	(Postfix) with ESMTP id 5658C112807E	for <linuxppc-dev@ozlabs.org>;
	Sat, 27 Feb 2010 01:56:22 +0000 (UTC)
Received: from SG2EHSMHS006.bigfish.com (unknown [10.210.100.247])	by
	mail13-sin.bigfish.com (Postfix) with ESMTP id 0E87D1C3004E	for
	<linuxppc-dev@ozlabs.org>; Sat, 27 Feb 2010 01:56:21 +0000 (UTC)
Received: from unknown-38-66.xilinx.com ([149.199.38.66]
	helo=xsj-smtp1.xilinx.com)	by xsj-gw1 with esmtp (Exim
	4.63)	(envelope-from
	<John.Linn@xilinx.com>)	id 1NlBvt-0003Lm-Ab	for linuxppc-dev@ozlabs.org;
	Fri, 26 Feb 2010 17:57:29 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: PCI NIC for powerpc system
Date: Fri, 26 Feb 2010 18:57:23 -0700
From: John Linn <John.Linn@xilinx.com>
To: <linuxppc-dev@ozlabs.org>
Message-ID: <8f766422-4c34-416e-9ae1-95fac2586cdb@SG2EHSMHS006.ehs.local>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I should apologize ahead of time for my lack of knowledge with PCI.

I'm trying to better understand if I can run a standard off the shelf
PCI NIC with a powerpc kernel as the PCI with device tree is not clear
to me.

I don't see many Ethernet drivers having OF support in them so maybe
devices on the PCI bus are discovered by the kernel such that the
drivers don't need to be OF aware.

Any advice is appreciated.

Thanks,
John

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
