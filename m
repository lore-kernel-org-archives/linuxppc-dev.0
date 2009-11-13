Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A8192B7B66
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Nov 2009 07:17:05 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nADKH2Ya019636
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 13:17:03 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id nADKKsSi012653
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 14:20:54 -0600 (CST)
Message-ID: <4AFDBED8.2040202@freescale.com>
Date: Fri, 13 Nov 2009 14:17:28 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: Re: Bus Error on MPC8313
References: <576259.11113.qm@web83501.mail.sp1.yahoo.com>
In-Reply-To: <576259.11113.qm@web83501.mail.sp1.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ron Madrid wrote:
>> Are there any filesystems mounted on NAND?  There are
>> some issues with transactions timing out if there's
>> contention with a long-running NAND operation.
> 
> Yes, a JFFS2.  If that is the case, is there any sort of
> workaround?

I've just posted some patches to linuxppc-dev and linux-mtd.

However, this can still result in large latencies -- you may want to add 
some software synchronization between NAND and other localbus users.

-Scott
