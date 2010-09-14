Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) by ozlabs.org (Postfix) with ESMTP id 4E9BDB70A5
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Sep 2010 05:44:56 +1000 (EST)
Received: from mail44-tx2 (localhost.localdomain [127.0.0.1])	by
	mail44-tx2-R.bigfish.com (Postfix) with ESMTP id 1E1B96E01C1	for
	<linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2010 19:44:53 +0000 (UTC)
Received: from TX2EHSMHS004.bigfish.com (unknown [10.9.14.249])	by
	mail44-tx2.bigfish.com (Postfix) with ESMTP id EFE27C18061	for
	<linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2010 19:44:51 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o8EJinGs003895	for <linuxppc-dev@ozlabs.org>;
	Tue, 14 Sep 2010 12:44:49 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o8EJvNOw021125	for <linuxppc-dev@ozlabs.org>;
	Tue, 14 Sep 2010 14:57:23 -0500 (CDT)
Message-ID: <4C8FD0B0.70500@freescale.com>
Date: Tue, 14 Sep 2010 14:44:48 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] hvc_console: fix dropping of characters when output byte
	channel is full
References: <1282329921-24394-1-git-send-email-timur@freescale.com>	<20100914121721.c8671ed8.akpm@linux-foundation.org>	<20100914204410.71942cdc@lxorguk.ukuu.org.uk>	<4C8FCC2E.1020107@freescale.com>
	<20100914205246.0e35c9af@lxorguk.ukuu.org.uk>
In-Reply-To: <20100914205246.0e35c9af@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: kumar.gala@freescale.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, amit.shah@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alan Cox wrote:
> If you want to make that change then I guess you need to audit every
> other hvc driver first.
> 
> But I never understood the point of the hvc layer anyway 8)

We've come to the same conclusion here.  I think we're just going to drop
the hvc layer and make the driver a standard console driver.

-- 
Timur Tabi
Linux kernel developer at Freescale
