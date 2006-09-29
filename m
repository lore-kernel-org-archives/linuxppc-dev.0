Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 05E6367BCB
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Sep 2006 06:30:02 +1000 (EST)
Message-ID: <451D8246.7060703@freescale.com>
Date: Fri, 29 Sep 2006 15:29:58 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Chris Boot <bootc@bootc.net>
Subject: Re: SATA: "unknown partition table" error, fdisk can't fix, works
	in 2.6.13
References: <451D7DE8.8020504@freescale.com>
	<BA55C0C9-B58F-473E-9412-B582411D017A@bootc.net>
In-Reply-To: <BA55C0C9-B58F-473E-9412-B582411D017A@bootc.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Chris Boot wrote:
> Timur,
> 
> fdisk manipulates DOS-style partition maps. Have you compiled these into 
> your latest kernel? You don't actually have any errors in the below 
> messages, other than the partition map being unreadable...

Yes, that was it!  Thank you very much.  All I had to do was select "PC BIOS (MSDOS partition tables) support" configuration option, and that was it.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
