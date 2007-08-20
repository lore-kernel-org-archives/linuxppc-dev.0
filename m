Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by ozlabs.org (Postfix) with ESMTP id E73E0DDEEE
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Aug 2007 03:42:45 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so777055wag
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Aug 2007 10:42:44 -0700 (PDT)
Message-ID: <fa686aa40708201042u546eb183mb52890d52aacb92a@mail.gmail.com>
Date: Mon, 20 Aug 2007 11:42:44 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Robert Woodworth" <rwoodworth@securics.com>
Subject: Re: Xilinx Virtex4 FX PPC
In-Reply-To: <1187630817.6336.34.camel@PisteOff>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1187625654.6336.28.camel@PisteOff>
	<20070820113549.7cc3ac45@weaponx.rchland.ibm.com>
	<1187630817.6336.34.camel@PisteOff>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/20/07, Robert Woodworth <rwoodworth@securics.com> wrote:
> CONFIG_MATH_EMULATION fixed it!!
>
> What are the opinions out there?
> Kernel fp or glibc soft-fp??

kernel fp is slower, but easier to get going (you can use just about
any distro).  soft-fp results in faster floating point execution, but
your entire rootfs needs to be compiled with soft-fp.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
