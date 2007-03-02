Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F3F06DDD0E
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Mar 2007 04:23:51 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: DMA take 2
Date: Fri, 2 Mar 2007 09:21:19 -0800
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C069AF9@MERCURY.inside.istor.com>
References: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A181@MERCURY.inside.istor.com>
From: "Charles Krinke" <ckrinke@istor.com>
To: <linuxppc-embedded@ozlabs.org>
Cc: Randy Brown <rbrown@istor.com>, Chris Carlson <ccarlson@istor.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Let me try my DMA question a bit more concisely to the linuxppc group.
=20
I am working on a DMA routine for the 8541 and the status register ends =
up with the CB (ChannelBusy) bit set, which I suspect is a programming =
error on my part.
=20
So, the question is:
=20
"What are the common programming errors that lead to SR0[CB] set at the =
end of a DMA transaction in an 8541?"
=20
Charles
