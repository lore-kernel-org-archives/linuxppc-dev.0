Return-Path: <markc@mail.com>
Received: from relay03.roc.ny.frontiernet.net (relay03.roc.ny.frontiernet.net
	[66.133.182.166]) by ozlabs.org (Postfix) with ESMTP id 29244679F2
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Jun 2005 21:20:26 +1000 (EST)
Message-ID: <002201c56ce5$561a6c50$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Grant Likely" <glikely@gmail.com>,
	<linuxppc-embedded@ozlabs.org>
References: <528646bc05060816514c2d5860@mail.gmail.com>
Date: Thu, 9 Jun 2005 07:21:06 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: MPC52xx: sysfs failure on adding new device driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>I'm working on an MPC52xx SPI device driver using one of the PSC. 
>However, when I call driver_register() I get a failure (-17, EEXISTS)
>with a traceback (posted below).

Hey Grant,

This sounds exactly like a problem I had with PSC with devfs.  I posted
a patch here on 5/27, I bet you'll find it's a similar problem.  

(Let me know if you don't have access to that patch, I'll forward you my
copy)

Mark Chambers
