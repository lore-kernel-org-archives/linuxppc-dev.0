Return-Path: <david.goodenough@btconnect.com>
Received: from mail.ukfsn.org (mail.ukfsn.org [77.75.108.10])
	by ozlabs.org (Postfix) with ESMTP id EB983B7D24
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Mar 2010 09:49:04 +1100 (EST)
Received: from localhost (smtp-filter.ukfsn.org [192.168.54.205])
	by mail.ukfsn.org (Postfix) with ESMTP id 35474DEBD4
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Mar 2010 22:49:03 +0000 (GMT)
Received: from mail.ukfsn.org ([192.168.54.25])
	by localhost (smtp-filter.ukfsn.org [192.168.54.205]) (amavisd-new,
	port 10024) with ESMTP id 6n-X9e3jom9x for <linuxppc-dev@ozlabs.org>;
	Tue, 16 Mar 2010 22:49:03 +0000 (GMT)
Received: from stargate.localnet (unknown [84.45.236.142])
	by mail.ukfsn.org (Postfix) with ESMTP id 0DCA1DEBB7
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Mar 2010 22:49:03 +0000 (GMT)
To: linuxppc-dev@ozlabs.org
Subject: Can the OpenRB board descriptions be merged into the mainline kernel?
From: David Goodenough <david.goodenough@btconnect.com>
Date: Tue, 16 Mar 2010 22:49:01 +0000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201003162249.01700.david.goodenough@btconnect.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

OpenWRT has some fixes which adds the board descriptions for the OpenRB
(ppc504 based boards).  Is there any reason why these should not be
merged into the mainline kernel?  The fixes are all licences GPL2.

If not do you want the original authors to submit them, or shall I take the
OpenWRT specific bits out and post them here?

David
