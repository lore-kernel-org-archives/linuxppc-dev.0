Return-Path: <sbajaj@tsi-telsys.com>
Received: from exchange.tsi-telsys.com (unknown [205.230.130.11])
	by ozlabs.org (Postfix) with ESMTP id 3B4B1679F1
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 May 2005 04:14:25 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 19 May 2005 14:14:20 -0400
Message-ID: <0007F077BB3476449151699150E8FEA21A7B9D@exchange.tsi-telsys.com>
From: "Sanjay Bajaj" <sbajaj@tsi-telsys.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: tah reset?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

While trying to reset the TAH on emac2 of PPC440GX, the Soft Reset (SR) =
bit never resets itself to 0. Does anybody know the reason for it?

Sanjay
