Return-Path: <edjubenville@adelphia.net>
Received: from mta10.adelphia.net (mta10.adelphia.net [68.168.78.202])
	by ozlabs.org (Postfix) with ESMTP id 59130DDE44
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Feb 2007 02:49:39 +1100 (EST)
Received: from EJ1 ([75.83.100.4]) by mta10.adelphia.net
	(InterMail vM.6.01.05.02 201-2131-123-102-20050715) with SMTP
	id <20070212154937.GQXS22452.mta10.adelphia.net@EJ1>
	for <linuxppc-embedded@ozlabs.org>; Mon, 12 Feb 2007 10:49:37 -0500
From: "Edward Jubenville" <edjubenville@adelphia.net>
To: "Linuxppc-Embedded" <linuxppc-embedded@ozlabs.org>
Subject: Finding devices with dynamic IP addresses
Date: Mon, 12 Feb 2007 07:49:32 -0800
Message-ID: <GPECLCIGPLHEOMGPMCPACELEEGAA.edjubenville@adelphia.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I hope this isn't off topic here...

My network will contain several ELDK-based devices configured with dynamic
IP addresses (DHCP).  I need a way for any Windows PC on the subnet to
locate the devices without prior knowledge of their IP address.  I'm hoping
to find a peer-to-peer
solution that doesn't involve a third party (DNS) server.

Can anyone recommend a strategy for finding devices with dynamic IPs?

I'm using ELDK 3.1 on a custom MPC5200-based board.

Thanks,

Ed Jubenville
