Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7780FB6EDF
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Nov 2009 06:33:10 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nADJX7Pq009271
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 12:33:07 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id nADJX8EH026093
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 13:33:08 -0600 (CST)
Message-ID: <4AFDB48D.9080203@freescale.com>
Date: Fri, 13 Nov 2009 13:33:33 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: Re: Bus Error on MPC8313
References: <705994.38950.qm@web83505.mail.sp1.yahoo.com>
In-Reply-To: <705994.38950.qm@web83505.mail.sp1.yahoo.com>
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
> I wrote a custom driver for an MPC8313 based board.  Everything seems to
> have been working for a long time, but now one of my IOCTL functions seems
> to be having a problem.  I'm getting a "Bus error" reported by my
> application and also a kernel "Oops".  Here's what the kernel is reporting. 
> 
> Oops: Machine check, sig: 7 [#1]

Were there any messages before this?  Is there anything interesting in 
the arbiter registers?

Is this custom driver using the localbus, and are there any NAND 
operations going on at the same time?

-Scott
