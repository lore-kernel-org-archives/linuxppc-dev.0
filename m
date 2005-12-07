Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5ED4E68873
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Dec 2005 15:44:02 +1100 (EST)
In-Reply-To: <000a01c5fae0$98ae1150$0760120a@photon>
References: <000a01c5fae0$98ae1150$0760120a@photon>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <03f747f66110e0d5976c2c03a76945aa@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 6 Dec 2005 20:43:49 -0800
To: "HappyPhot" <happyphot@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC8245 with its internal UART
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Dec 6, 2005, at 7:44 PM, HappyPhot wrote:

> Who can tell me which flatform is similar to mine ? I've tried
> "make sandpoint_defconfig", but seems not the right one.

That's the one I would have recommended.  I don't think there
is any Linux platform port that uses the 8245 internal DUART,
at least not in the public source tree.  The DUART is actually
pretty easy, just use the generic 8250 driver and point the address
to the Embedded Utilities Block DUART.


	-- Dan
