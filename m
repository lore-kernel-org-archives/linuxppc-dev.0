Return-Path: <mgberry@ellipticity.com>
Received: from waffle.digitalsmiths.com (waffle.digitalsmiths.com
	[66.194.119.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "plesk", Issuer "plesk" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E132D67B94
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Jul 2005 04:13:13 +1000 (EST)
Message-ID: <20050711141309.1i0ave70iyo0s084@webmail.ellipticity.com>
Date: Mon, 11 Jul 2005 14:13:09 -0400
From: mgberry@ellipticity.com
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1
Subject: MPC5200 Rev. B
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>Are you sure you have revision B of the MPC5200?  Freescale has
>announced a "B" version, but I don't believe that any of them have
>hit the public yet.  There may be some engineering grade samples out
>there. (Let me know if you really do have "B" parts.  Freescale has
>been telling me "real soon now" since last year)


We have receieved 10 samples of Rev. B last week.  Part # PPC5200CBV400B

Sounds like others may be having similiar problems, glad to know Im not the only
frustrated one here.  The schedule freescale provided showed a production
release in July that would resolve these issues.  The reason we went to the
Rev. B was because the PCI Bridge PLX6152 would not respond due to PCI timing
errata in the 5200.  The suggested workaround seemed unfeaseable due to the
local bus being shared.  Any input?

Matt Berry
Austin, TX
