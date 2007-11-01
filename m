Return-Path: <Emilian.Medve@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 21248DDDE4
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Nov 2007 10:35:01 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	lA1NYtZS023148
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Nov 2007 16:34:56 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net
	[10.64.32.14])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id lA1NYtae006248
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Nov 2007 18:34:55 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: Module with 36K relocation entries
Date: Thu, 1 Nov 2007 16:34:54 -0700
Message-ID: <598D5675D34BE349929AF5EDE9B03E270174CC98@az33exm24.fsl.freescale.net>
From: "Medve Emilian-EMMEDVE1" <Emilian.Medve@freescale.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,


I have module with 36K relocation entries (I know, I know, how could
that be...) and the count_relocs() function takes ~17 seconds to crunch
through the relocation table from the .rela.text section. I don't think
I can reduce the number of entries in the relocation table (can I?) so
I'm thinking at improving the performance of count_relocs() (currently
O(n^2)). Does anybody have a simpler idea? Does anyone have any
constructive suggestion on how to improve the situation?


Thank you,
Emil.
