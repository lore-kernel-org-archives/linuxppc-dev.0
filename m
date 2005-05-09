Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 40CDA67A6D
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 May 2005 22:01:00 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j49C5XtH006697
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 9 May 2005 15:05:36 +0300 (EEST)
Message-ID: <427F4D28.4090204@intracom.gr>
Date: Mon, 09 May 2005 14:44:40 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>, Kumar Gala <kumar.gala@freescale.com>,
	Eugene Surovegin <ebs@ebshome.net>, Vitaly Bordug <vbordug@ru.mvista.com>,
	Tom Rini <trini@kernel.crashing.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Jason McMullan <jason.mcmullan@timesys.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [HEADS UP]  Freescale Ethernet combined driver
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

A patch containing a combined Freescale Ethernet driver for the
PQI/PQII, will follow. The patch is against 2.6.11.7 since my git-foo
is at bit weak.

Note that it's not a superset of all the FEC/FCC drivers floating
around; it's geared to be the base of the final community developed driver.

Let's talk about it...

Regards

Pantelis
