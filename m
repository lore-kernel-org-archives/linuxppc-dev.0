Return-Path: <trueskew@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.195])
	by ozlabs.org (Postfix) with ESMTP id 5E62A67B44
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Jun 2006 07:18:30 +1000 (EST)
Received: by nz-out-0102.google.com with SMTP id i11so1482466nzi
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Jun 2006 14:18:29 -0700 (PDT)
From: "Trueskew" <trueskew@gmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: RE: MPC5200B SPI PSC3 Problem
Date: Tue, 13 Jun 2006 14:11:31 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: 
Message-ID: <448f2a0a.1c031bbb.392c.2ee5@mx.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ok, I'm slightly less confused, and since I may have caused confusion I'll
clarify a little here.  Sorry if some of you knew this already.

The MPC5200B has an SPI interface described in Chapter 17 of the MPC5200B
Users Guide.  It uses either lines PSC3_6 - PSC3_9, or some of the Timer
pins.  The MPC5200B also has an SPI available through the PSCs that use the
codec lines (PSC3_0 - PSC3_3).  Depending on what rev of the user's guide
you have, there's a table in Chapter 15 that suggests you can set up PSC3
for Codec and SPI.  Unfortunately, the SPI they're talking about is the
8-bit SPI, not the PSC3 SPI.  

That was the basic source for my confusion.  Hints here and in other places
and some parts of the manual suggested, but it was the scope that really
drove that home for me.  I won't elaborate anymore here since for all I know
I'm the only person who just figured that out, but if anyone is struggling
like I just did and has any questions, I'm not a guru but I'll try to help.

Good luck.
