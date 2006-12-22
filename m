Return-Path: <beattie@beattie-home.net>
Received: from mail.beattie-home.net (gw.beattie-home.net [66.93.38.225])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E4AFFDDEB9
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Dec 2006 11:06:34 +1100 (EST)
Received: from localhost.localdomain (caliban.beattie-home.net [66.93.38.182])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail.beattie-home.net (Postfix) with ESMTP id C9E87E346AD
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Dec 2006 15:54:03 -0800 (PST)
Subject: MPC8249 PCI Bus 2
From: Brian Beattie <beattie@beattie-home.net>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Fri, 22 Dec 2006 15:47:00 -0800
Message-Id: <1166831220.5602.14.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm working on bringing up a board and having some trouble with the
second PCI Bus and was wondering if anybody had any idea.

The kernel is 2.6.19.1 patched to set the Local Access Window because
out u-boot does not do that yet.  I have an Intel 82541 GigE chip
hanging off PCI Bus 1 that seems to be working fine.

On Bus 2 I have a mini-pci connector:

Trying an el-cheapo i82551 based 10/100 NIC it hangs after about 5 pings
on an quiet segment and before I can send anything on a noisy segment
with both the eepro100 and e100 drivers.

Trying a prism II based wireless nic, it fails in the device probe
trying to read a status register because the result is all ones (as if
nothing is there).

Near as I can tell I am getting interrupts.

-- 
Brian Beattie   LFS12947 | "Honor isn't about making the right choices.
beattie@beattie-home.net | It's about dealing with the consequences."
www.beattie-home.net     | -- Midori Koto
