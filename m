Return-Path: <CFRIESEN@nortel.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D5EB8B6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Jul 2009 04:43:50 +1000 (EST)
Received: from zcars04e.nortel.com (zcars04e.nortel.com [47.129.242.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 10B1FDDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2009 04:43:49 +1000 (EST)
Received: from zcarhxs1.corp.nortel.com (casmtp.ca.nortel.com [47.129.230.89])
	by zcars04e.nortel.com (Switch-2.2.0/Switch-2.2.0) with ESMTP id
	n6RIfrt01768
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2009 18:41:53 GMT
Message-ID: <4A6DF55A.9050707@nortel.com>
Date: Mon, 27 Jul 2009 12:43:38 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: anyone know of a patch to support mcpn905/cpci6115 on recent-ish
	kernels?
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


We've got some people that are currently running an older linux kernel
(from before the ppc/ppc64 merge and the conversion to device tree) on
an Emerson/Motorola cpci6115 (also known as mcpn905) compactPCI board.
They're wondering if it's possible to upgrade to a more recent kernel.

I don't see support for these boards in mainline, but is anyone aware of
patches adding support for more recent kernels?

Barring that, are there any tutorials out there on how to build a dts
file from scratch?  I think we've got the hardware specs, and we've got
a running earlier kernel.

Thanks,

Chris
