Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 7D2971007D7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2011 02:30:34 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 22887-08 for <linuxppc-dev@lists.ozlabs.org>;
 Thu, 24 Nov 2011 15:30:30 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 01/16] pmac_zilog: fix unexpected irq
Date: Thu, 24 Nov 2011 15:28:38 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AEE1@saturn3.aculab.com>
In-Reply-To: <alpine.LNX.2.00.1111250133321.6314@nippy.intranet>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Finn Thain" <fthain@telegraphics.com.au>,
 "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-m68k@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> On most 68k Macs the SCC IRQ is an autovector interrupt and cannot be=20
> masked. This can be a problem when pmac_zilog starts up.

Wouldn't this also happen if the interrupt were shared?
Hopefully nothing vaguely modern uses the borked Zilog 8530 SCC
(which I presume is the part in question - brings back
too many nightmares....)

	David
