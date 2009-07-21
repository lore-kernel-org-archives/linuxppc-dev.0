Return-Path: <felix@embedded-sol.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 69502B7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Jul 2009 19:21:09 +1000 (EST)
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 17AD1DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2009 19:21:08 +1000 (EST)
Received: from bzq-79-180-129-18.red.bezeqint.net ([79.180.129.18]:50697
	helo=felix.lan) by vega.surpasshosting.com with esmtpa (Exim 4.69)
	(envelope-from <felix@embedded-sol.com>) id 1MTBWw-0007Zf-2G
	for linuxppc-dev@ozlabs.org; Tue, 21 Jul 2009 05:21:02 -0400
Message-ID: <4A65887B.8090103@embedded-sol.com>
Date: Tue, 21 Jul 2009 12:20:59 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: DMA Engine on MPC8270
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Can Freescale DMA engine driver can be used on MPC2870 ?
If not, what driver should I use instead ? The goal to to speed up
transfers to some storage device (M-Systems DoC H3).

Thanks a lot.

Felix.
