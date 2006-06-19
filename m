Return-Path: <dwm@maxeymade.com>
Received: from bebe.enoyolf.org (falcon30.maxeymade.com [24.173.215.190])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.maxeymade.com",
	Issuer "ChainedSSL Certificate Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTP id CC09767A41
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2006 03:46:18 +1000 (EST)
Received: from bebe.enoyolf.org (localhost.localdomain [127.0.0.1])
	by bebe.enoyolf.org (8.13.6/8.13.6) with ESMTP id k5JHJhWc013728
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jun 2006 12:19:43 -0500
To: linuxppc-dev@ozlabs.org
Subject: OFW node names 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 19 Jun 2006 12:19:43 -0500
Message-ID: <20060619171943.7730@bebe.enoyolf.org>
From: Doug Maxey <dwm@maxeymade.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Howdy!

I'm looking at page 164 in the 1275-1994 at the "name" entry.

Does any platform known to use yaboot (or grub for that matter) use the
preferred encoding of the manufacturer portion of the name property?
How about the "ONNNNN" OUI from the RAC, or the uppercase VWXYZ company stock symbol?

My view has been limited to the IBM platform.  According to the 
examples, this is a recommended practice.  I know IBM uses the 
lowercase variant.

If anyone has an example, please point me at tarball of the device tree.

++doug
