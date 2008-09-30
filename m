Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9589DDE87C
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Oct 2008 03:18:33 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m8UHDTYW004891
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 10:13:31 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m8UH8mea022467
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 12:08:49 -0500 (CDT)
Date: Tue, 30 Sep 2008 12:08:47 -0500
From: Scott Wood <scottwood@freescale.com>
To: Martyn Welch <martyn.welch@gefanuc.com>
Subject: Re: [PATCH] powerpc: GE Fanuc's FPGA based PIC controller on the
	SBC610
Message-ID: <20080930170847.GA25725@ld0162-tx32.am.freescale.net>
References: <20080930142942.28193.943.stgit@ubuntu8041.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080930142942.28193.943.stgit@ubuntu8041.localdomain>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 30, 2008 at 03:29:42PM +0100, Martyn Welch wrote:
> +		gef_pic: pic@4,4000 {
> +			#interrupt-cells = <2>;

What is the second interrupt cell for, given that all interrupts are
level-triggered and you don't implement .set_type?

-Scott
