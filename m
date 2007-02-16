Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 95F4FDDDDB
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Feb 2007 04:40:59 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Finding devices with dynamic IP addresses
Date: Fri, 16 Feb 2007 11:28:52 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B02912B95@ismail.innsys.innovsys.com>
In-Reply-To: <GPECLCIGPLHEOMGPMCPACELEEGAA.edjubenville@adelphia.net>
References: <GPECLCIGPLHEOMGPMCPACELEEGAA.edjubenville@adelphia.net>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Edward Jubenville" <edjubenville@adelphia.net>,
	"Linuxppc-Embedded" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> From: Edward Jubenville
> Can anyone recommend a strategy for finding devices with dynamic IPs?

To do somehting similar here, we use a scheme were the windows host
sends out a UDP broadcast message, and all the devices have daemon
running, listening to that broadcast, and sends back (via broadcast) a
response with the IP address and serial number embedded.

We use this to identify all running devices on the network.
This only works within the same subnet.
