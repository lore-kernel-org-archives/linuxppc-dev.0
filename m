Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de",
	Issuer "StartCom Class 1 Primary Intermediate Server CA" (not
	verified)) by ozlabs.org (Postfix) with ESMTPS id 97201DDDF3
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Nov 2008 22:45:02 +1100 (EST)
Message-ID: <490EE408.2050704@scram.de>
Date: Mon, 03 Nov 2008 12:44:08 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH] i2c-cpm: Detect and report NAK right away instead of
	timing out.
References: <490BA2E5.8010309@consentry.com>
	<20081103002328.GC30438@fluff.org.uk>
In-Reply-To: <20081103002328.GC30438@fluff.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org,
	Mike Ditto <mditto@consentry.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben,

> On Fri, Oct 31, 2008 at 05:29:25PM -0700, Mike Ditto wrote:
>> Make the driver report an ENXIO error immediately upon NAK instead of
>> waiting for another interrupt and getting a timeout.
>>
>> Signed-off-by: Mike Ditto <mditto@consentry.com>

Acked-by: Jochen Friedrich <jochen@scram.de>

> It looks ok, I'll merge and push out to linus with the s3c fixes.

Thanks!

Jochen
