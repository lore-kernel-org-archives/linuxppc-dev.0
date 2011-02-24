Return-Path: <John.Linn@xilinx.com>
Received: from VA3EHSOBE002.bigfish.com (va3ehsobe002.messaging.microsoft.com
	[216.32.180.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C68D0B7161
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Feb 2011 12:20:00 +1100 (EST)
Received: from mail83-va3 (localhost.localdomain [127.0.0.1])	by
	mail83-va3-R.bigfish.com (Postfix) with ESMTP id 9C411720129	for
	<linuxppc-dev@ozlabs.org>; Thu, 24 Feb 2011 01:04:51 +0000 (UTC)
Received: from VA3EHSMHS029.bigfish.com (unknown [10.7.14.249])	by
	mail83-va3.bigfish.com (Postfix) with ESMTP id 7841C43004C	for
	<linuxppc-dev@ozlabs.org>; Thu, 24 Feb 2011 01:04:51 +0000 (UTC)
Received: from unknown-38-66.xilinx.com ([149.199.38.66]
	helo=xsj-smtp1.xilinx.com)	by xsj-gw1 with esmtp (Exim
	4.63)	(envelope-from
	<John.Linn@xilinx.com>)	id 1PsPdS-0006AI-Ep	for linuxppc-dev@ozlabs.org;
	Wed, 23 Feb 2011 17:04:50 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: Flushing data cache on PPC405 in Linux
Date: Wed, 23 Feb 2011 18:04:47 -0700
From: John Linn <John.Linn@xilinx.com>
To: <linuxppc-dev@ozlabs.org>
Message-ID: <ef11a825-8824-460f-91c0-82cb8029ed81@VA3EHSMHS029.ehs.local>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I have a situation that requires a flush the data cache at specific time
periods to help with memory scrubbing.

On the 405, I don't see any easy way to do this since you don't know
what the cache has in it and there's not an instruction to flush the
whole cache.  It looks like a kernel driver is needed to map pages then
flush that data cache for the pages. =


I'm concerned there will be side affects I don't realize as I'm assuming
the driver would slowly go thru all of physical memory mapping pages
(cached or non-cached) and then flushing all addresses in the page(s).

Any thoughts?

Thanks,
John

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
