Return-Path: <SSparks@aclaratech.com>
Received: from WA4EHSOBE002.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16]) by ozlabs.org (Postfix) with ESMTP id 523A4DE787
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 05:24:37 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: mpc8349-mITX DTB load failure
Date: Mon, 28 Jul 2008 14:22:47 -0500
Message-ID: <6011A7C9CD0EE74792C3ED2A8355608634214F@mail.twacs.com>
In-Reply-To: <20080728133043.563a691c.kim.phillips@freescale.com>
References: <6011A7C9CD0EE74792C3ED2A8355608634213E@mail.twacs.com>
	<20080728133043.563a691c.kim.phillips@freescale.com>
From: "Sparks, Sam" <SSparks@aclaratech.com>
To: "Kim Phillips" <kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> From: Kim Phillips
> Sent: Monday, July 28, 2008 1:31 PM
> > ## Booting kernel from Legacy Image at 01001000 ...
>=20
> > ## Flattened Device Tree blob at 01000000
>=20
> so the dtb is being loaded only 0x1000 bytes from the kernel,=20
> yet it's probably bigger than that.  Can you try different=20
> load addresses, preferably with the two images at least=20
> 0x3000 bytes apart?

Ouch. Thanks for pointing that out, it worked. :-)

--Sam
