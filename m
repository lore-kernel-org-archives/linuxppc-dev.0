Return-Path: <vbendeb@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id 37E28DDE01
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Oct 2008 14:38:34 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m33so460919wag.9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 01 Oct 2008 21:38:33 -0700 (PDT)
Message-ID: <f608b67d0810012138w64ba5ecbg1f88fff505c820b7@mail.gmail.com>
Date: Wed, 1 Oct 2008 21:38:32 -0700
From: vb <vb@vsbe.com>
Sender: vbendeb@gmail.com
To: linuxppc-embedded@ozlabs.org
Subject: EMAC2 in ibm_newemac driver
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have a 460GT based system with three ethernet interfaces, and I
don't seem to be able to bring up EMAC2 in RGMII mode. The PHY works
just fine, the counterpart on the other side of the serdes link
autonegotiates successfully, etc. When I attempt to send something
from the interface though, nothing shows up on the RGMII lines (I use
a scope to probe it). The received traffic is passed from the  PHY to
the MAC, but again, nothing is reported by the rx driver.

I am using the latest released code from 2.6.26.5 (I started with
2.6.25 release, and in that case just EMAC0 worked, updgrading to to
2.6.26.5 made the second interface work, but the third one seems to be
stuck. I see that the Denx tree has a lot of changes in the driver,
but it is not as cleanly portable, so advancing  there is not an
option.

I am trying to debug it, but  am wondering if anyone had more than two
interfaces going on this architecture and if so - what are the
gotchas.

Any hints will be highly appreciated,

cheers,
VadimB
