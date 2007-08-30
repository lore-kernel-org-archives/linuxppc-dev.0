Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it (unknown [213.82.155.20])
	by ozlabs.org (Postfix) with ESMTP id AB874DDE47
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Aug 2007 23:59:46 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Network is blocked till ping is issued
Date: Thu, 30 Aug 2007 15:59:43 +0200
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8EA1876A@aquib01a>
In-Reply-To: <bdfc5d6e0708300552g71a995c9x10f17322613ca9c1@mail.gmail.com>
From: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
To: "Andy Gospodarek" <andy@greyhouse.net>
Cc: "Florian A. Voegel" <fvoegel@carangul.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


>No.  You are confusing Ethernet frames and IP packets a little bit.
>If a Linux machine receives a SYN from a remote host (not on the same
>network) then the Linux machine needs to ARP for the router that is
>listed as the default route in the routing table.

>If no such default route exists, you will not be able to reach the
>remote host.  If the router doesn't reply to your ARP request, you
>will not be able to reach the remote host.

>Check to make sure you are not having either one of these problems.

I'm on the same network: NotLinux is 100.1.0.1 and Linux is 100.1.0.2
with netmask 255.255.255.0

Thank you,
Antonio.
