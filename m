Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id AAC4CDDFBC
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 03:18:55 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l1FGIqNJ001294
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 09:18:52 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l1FGIpGr026556
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 10:18:52 -0600 (CST)
Message-ID: <45D487EB.4090105@freescale.com>
Date: Thu, 15 Feb 2007 10:18:51 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: delete boot-cpu and chosen nodes from all DTS
	files
References: <11713852392294-git-send-email-timur@freescale.com>
	<20070214003119.GF11491@localhost.localdomain>
	<45D29BBA.7090401@freescale.com>
	<20070214052440.GB12609@localhost.localdomain>
	<45D31734.7030808@freescale.com>
	<20070214233348.GH16279@localhost.localdomain>
In-Reply-To: <20070214233348.GH16279@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:

> My point is that the interrupt-controller property in /chosen *should*
> be there, but it doesn't make a lot of sense for it to be set by the
> bootloader (because it's a fixed property of the board).  Therefore it
> should be in the dts, therefore the /chosen node needs to be there to
> contain it.

Ok, I've added that to my to-do list.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
