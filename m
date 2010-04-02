Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de",
	Issuer "StartCom Class 1 Primary Intermediate Server CA" (not
	verified)) by ozlabs.org (Postfix) with ESMTPS id 8E225B7CEF
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Apr 2010 22:51:07 +1100 (EST)
Message-ID: <4BB5D634.1020101@scram.de>
Date: Fri, 02 Apr 2010 13:34:12 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH RESEND 2/3] i2c/cpm: drop NO_IRQ
References: <1270167421-5205-1-git-send-email-w.sang@pengutronix.de>
	<1270167421-5205-3-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1270167421-5205-3-git-send-email-w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org,
	Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Wolfram Sang wrote:

> Drop NO_IRQ as 0 is the preferred way to describe 'no irq'

> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
Acked-by: Jochen Friedrich <jochen@scram.de>

Thanks,
Jochen
