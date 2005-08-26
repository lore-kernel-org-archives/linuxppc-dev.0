Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 6C44E6808E
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Aug 2005 08:48:59 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Fri, 26 Aug 2005 17:48:53 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B859440@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Tom Rini" <trini@kernel.crashing.org>, "Dan Malek" <dan@embeddededge.com>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Kumar Gala <galak@freescale.com>
Subject: RE: [PATCH] ppc32: add CONFIG_HZ
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday, August 26, 2005 16:32 Tom Rini wrote:
> So 250 is supposed to be the best choice of power vs latency and such.
> But hey, there's nothing stopping us from setting all of the embedded
> configs back down to 100 :)

I thought the default value for HZ in 2.6 was 1000?
At least this is what it is set at for the 82xx (and bigger embedded)
boards=20
