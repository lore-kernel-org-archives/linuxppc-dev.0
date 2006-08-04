Return-Path: <Behre.Frederik@litef.de>
Received: from proxy03.litef.de (brunello.litef.de [193.101.168.110])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 57467679FB
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Aug 2006 21:20:08 +1000 (EST)
Received: from frmx1.litef.de (localhost [127.0.0.1])
	by proxy03.litef.de (8.12.6/8.12.6/litef) with ESMTP id k74B4MtU024144
	for <linuxppc-embedded@ozlabs.org>; Fri, 4 Aug 2006 13:04:22 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Problem in __get_dma_page and __pa
Date: Fri, 4 Aug 2006 13:04:22 +0200
Message-ID: <CC692F5386B0AA47A62B7484A7CA2B6D0317C54B@frmx1.litef.de>
From: "Behre, Frederik - LT" <Behre.Frederik@litef.de>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

Did someone know if there are known problems in __get_dma_pages and __pa
in linux version 2.6.14 ?=20

Regards=20
Freddy
