Return-Path: <markc@mail.com>
Received: from relay04.roc.ny.frontiernet.net (relay04.roc.ny.frontiernet.net
	[66.133.131.37]) by ozlabs.org (Postfix) with ESMTP id 503FE2BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Nov 2004 04:45:55 +1100 (EST)
Message-ID: <005301c4cd96$c9915570$0601a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: =?iso-8859-1?Q?I=F1igo_Lopez_Barranco?= <ilopez@albatros-sl.es>,
	<linuxppc-embedded@ozlabs.org>
References: <42A622EB18325843894BB8E1040E3DF5022830@sinaexchf>
Date: Thu, 18 Nov 2004 12:48:05 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: Ethernet on 5200 is using DMA?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I don't think it's possible to NOT use DMA on a 5200.  If your link
is 100Mbps and you are putting out something close to that then
90% is not unreasonable.  There are still memory copies involved.

Where is it getting the large file from?  Maybe IDE is a bottleneck.

Mark Chambers
wvcomputronics.com

----- Original Message ----- 
From: "Iñigo Lopez Barranco" <ilopez@albatros-sl.es>
To: <linuxppc-embedded@ozlabs.org>
Sent: Thursday, November 18, 2004 11:55 AM
Subject: Ethernet on 5200 is using DMA?


Hi. I'm using linuxppc_2_4_devel from Denx CVS on a Lite5200 board.
When doing "put" of a large file to a ftp server, ftp eats all the CPU
available (90%+). I suspect it's not using DMA for the ethernet. Is this
right?
Thanks in advance.

Iñigo
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
