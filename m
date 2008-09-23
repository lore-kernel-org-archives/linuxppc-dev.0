Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0DFD3DDED8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Sep 2008 15:11:11 +1000 (EST)
Subject: RE: Regarding select() on PPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>
In-Reply-To: <7B7EF7F090B9804A830ACC82F2CDE95D56E14C@insardxms01.ap.sony.com>
References: <7B7EF7F090B9804A830ACC82F2CDE95D56E14C@insardxms01.ap.sony.com>
Content-Type: text/plain
Date: Tue, 23 Sep 2008 15:11:01 +1000
Message-Id: <1222146661.12085.90.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> >Your patch should be submitted to the linuxppc-dev mailing list btw.
> >
> 
> Will do that.

Don't bother for now. The right approach would be to just
get rid of the wrappers I believe. I'm sorting that out.

Ben.
