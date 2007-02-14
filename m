Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id D8C98DDE4A
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 10:47:25 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l1ENlMYQ013887
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 16:47:22 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l1ENlLvD028815
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 17:47:22 -0600 (CST)
Message-ID: <45D39F89.4040308@freescale.com>
Date: Wed, 14 Feb 2007 17:47:21 -0600
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

> Er.. I think you're missing something.
> 
> My point is that the interrupt-controller property in /chosen *should*
> be there, but it doesn't make a lot of sense for it to be set by the
> bootloader (because it's a fixed property of the board).  Therefore it
> should be in the dts, therefore the /chosen node needs to be there to
> contain it.

Ok, I understand.

Well, as soon as my other DTS-related patches are applied, I'll start working on 
one for the 'chosen' section.


-- 
Timur Tabi
Linux Kernel Developer @ Freescale
