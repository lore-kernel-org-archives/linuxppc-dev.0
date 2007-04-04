Return-Path: <linas@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 40297DDE39
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 03:50:31 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l34HoPmm031421
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Apr 2007 13:50:25 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l34HoPbv100486
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Apr 2007 13:50:25 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l34HoOaP026422
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Apr 2007 13:50:24 -0400
Date: Wed, 4 Apr 2007 12:50:23 -0500
To: David Lang <david.lang@digitalinsight.com>
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
Message-ID: <20070404175023.GV4922@austin.ibm.com>
References: <20070404024400.56d016e1@the-village.bc.nu>
	<Pine.LNX.4.63.0704031817020.21680@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.63.0704031817020.21680@qynat.qvtvafvgr.pbz>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	dwmw2@infradead.org, David Miller <davem@davemloft.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 03, 2007 at 06:23:07PM -0700, David Lang wrote:
> 
> people working with ~50 serial ports or ethernet ports aren't useing stock 
> distros anyway.

???  For "big servers", Suse SLES and RedHat RHEL are the defacto choices, 
with Ubuntu a rising star. It doesn't get much more stock than that.

> > Which is also another reason for building the "all serial devices"
> > mapping by using udev, as it can provide multiple simultaneous views. The
> > serial console unfortunately rather breaks that approach as Dave pointed
> > out
> 
> I would reverse this. instead of having a bunch of different names and then 
> requiring a tool to create sane names from them, start off with a nice nameing 
> scheme and have a tool that tells you the under-the-covers details.

Except that udev already exists, and is widely deployed by most distros
to handle the "sane naming" problem. In particular, "sane naming"
becomes hard if devices can be hotplugged, whether they are usb or pci
(e.g. a usb-to-serial converter).

--linas
