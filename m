Return-Path: <Fabien.Clement@thomson.net>
Received: from dmzraw4.extranet.thmulti.com (dmzraw4.extranet.thmulti.com
	[141.11.234.72]) by ozlabs.org (Postfix) with ESMTP id 6F50D681BD
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Jan 2006 05:30:08 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] CPM2: Fix totally bogus alignment handing of dpalloc
Date: Fri, 27 Jan 2006 19:09:35 +0100
Message-ID: <9C1918067C3BC14C9C351C206D8A843701F54C02@rennsmail03.eu.thmulti.com>
From: "Clement Fabien" <Fabien.Clement@thomson.net>
To: "Pantelis Antoniou" <panto@intracom.gr>, <galak@kernel.crashing.org>,
	"Marcelo Tosatti" <marcelo.tosatti@cyclades.com>,
	"linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Pantelis

What is the status for this patch - I did not see any approval in the
list.

For me it's ok and in "production" (except that I don't like the loss of
space but I can live with it)

Regards
Fabien

-----Original Message-----
From: Pantelis Antoniou [mailto:panto@intracom.gr]=20
Sent: jeudi 24 novembre 2005 12:04
To: Clement Fabien; Kumar Gala; Marcelo Tosatti; linuxppc-embedded
Subject: [PATCH] CPM2: Fix totally bogus alignment handing of dpalloc

Hi all.

Alignments are currently handled bogusly for cpm2.

Please test.

Regards

Pantelis
