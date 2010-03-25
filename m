Return-Path: <imp@bsdimp.com>
Received: from harmony.bsdimp.com (bsdimp.com [199.45.160.85])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7374EB7D15
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 10:59:04 +1100 (EST)
Date: Thu, 25 Mar 2010 17:53:43 -0600 (MDT)
Message-Id: <20100325.175343.706994262324563953.imp@bsdimp.com>
To: timur@freescale.com
Subject: Re: [PATCH] powerpc/fsl: add device tree binding for QE firmware
From: "M. Warner Losh" <imp@bsdimp.com>
In-Reply-To: <ed82fe3e1003250742t5affee7dudca651ab3352bc16@mail.gmail.com>
References: <4BAA4C8A.70104@freescale.com>
	<65327.84.105.60.153.1269481760.squirrel@gate.crashing.org>
	<ed82fe3e1003250742t5affee7dudca651ab3352bc16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In message: <ed82fe3e1003250742t5affee7dudca651ab3352bc16@mail.gmail.com>
            Timur Tabi <timur@freescale.com> writes:
: The initrd thing is a good idea, but it doesn't help non-Linux
: operating systems.  Then again, those OS's might not have any GPL
: issues, so it could be a moot point.

Most !linux systems are not GPL'd.  They are BSDL, primarily, or some
private license between seller and buyer.  In any event, other OSes
likely won't have the GPL issue.

But I'm confused.  If you can't distribute the binary firmware, why
can you distribute the hex dump of the firmware?

Warner
