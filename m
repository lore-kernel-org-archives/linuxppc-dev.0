Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.8])
	by ozlabs.org (Postfix) with ESMTP id 47C141007D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 09:21:03 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Bug in drivers/serial/of_serial.c?
Date: Sat, 21 Nov 2009 20:45:42 +0100
References: <8B957E110B62714A84290A01A597805F05CA0AA0@Exchange.discretix.com>
	<e846a32c-5f37-4531-b23d-17c60d8b6449@SG2EHSMHS010.ehs.local>
	<fa686aa40911202351s4436a8a6r59abfe2cf130ca59@mail.gmail.com>
In-Reply-To: <fa686aa40911202351s4436a8a6r59abfe2cf130ca59@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200911212045.42767.arnd@arndb.de>
Cc: Stephen Neuendorffer <stephenn@xilinx.com>, Alon Ziv <alonz@discretix.com>,
	linuxppc-dev@lists.ozlabs.org, John Linn <John.Linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Saturday 21 November 2009, Grant Likely wrote:
> BTW, while looking at that file... Arnd, does the .type = "serial"
> stuff really need to be there?

Well, serial is one of the few that actually has some preexisting
binding with a well defined device-type, so I guess we should use
it.

	Arnd <><
