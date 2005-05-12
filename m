Return-Path: <jjboor@aimsys.nl>
Received: from smtp06.wanadoo.nl (smtp06.wanadoo.nl [194.134.35.146])
	by ozlabs.org (Postfix) with ESMTP id 02ADF67B2E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 May 2005 20:53:06 +1000 (EST)
In-Reply-To: <427F4D41.10908@intracom.gr>
References: <427F4D41.10908@intracom.gr>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <883b9affce23db0859a4619cff66da4e@aimsys.nl>
From: Jaap-Jan Boor <jjboor@aimsys.nl>
Date: Thu, 12 May 2005 12:53:03 +0200
To: Pantelis Antoniou <panto@intracom.gr>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] Freescale Ethernet combined driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

May be a little late (I'm trying to catch up on all mailing list mail)
but I was wondering if the io port handling functions I see now in 
these patches
should not be 'atomic'. So toggling MII pins does not interfere with 
toggling
e.g. I2C bit-bang interface pins when those pins happen to be on the 
same
port (A/B/C/D/E).

best regards,

Jaap-Jan
