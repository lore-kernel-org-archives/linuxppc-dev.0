Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it (unknown [213.82.155.20])
	by ozlabs.org (Postfix) with ESMTP id 0F01BDDE25
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Aug 2007 16:24:38 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Network is blocked till ping is issued
Date: Thu, 30 Aug 2007 08:24:35 +0200
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8EA1869B@aquib01a>
In-Reply-To: <20070830010752.0ca3d309.fvoegel@carangul.com>
From: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
To: "Florian A. Voegel" <fvoegel@carangul.com>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> sounds to me like it could be a classical ARP problem. Have you
checked the ARP cache on the non-Linux
> machine?

But if Linux received the SYN packet of TCP connection, shouldn't the
Linux machine reply to the source mac address of SYN packet with a
SYN,ACK packet?
