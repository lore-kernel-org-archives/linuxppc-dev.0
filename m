Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9D67EDDFDA
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 07:24:22 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l98LOH9J026469
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Oct 2007 14:24:17 -0700 (MST)
Received: from [10.82.17.127] ([10.82.17.127])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l98LOGUa004634
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Oct 2007 16:24:17 -0500 (CDT)
Message-ID: <470AA012.9080401@freescale.com>
Date: Mon, 08 Oct 2007 16:24:34 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
Subject: bootwrapper: relative finddevice()
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'd like to expose flatdevtree's ability to do relative path lookups in 
ops, and I'd prefer to extend the existing finddevice method rather than 
add a new finddevice_rel.  However, I'm not very familiar with real OF 
-- how would one go about fixing its implementation?

-Scott
