Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.190]) by ozlabs.org (Postfix) with ESMTP id 7694E67A6D
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Feb 2005 20:57:56 +1100 (EST)
Message-ID: <41FF5346.1020208@anagramm.de>
Date: Tue, 01 Feb 2005 11:00:38 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Eugene K <evgfpeters@yahoo.com>, linuxppc-embedded@ozlabs.org
References: <20050131221106.21519.qmail@web51003.mail.yahoo.com>
In-Reply-To: <20050131221106.21519.qmail@web51003.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Re: Pointers to Linux portability docs
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, Eugene!

Eugene K wrote:
> We are starting development on Freescale 8540 (or
> 8548, depending on how ready the silicon is), and
> would highly appreciate any pointers to documentation
> on Linux portability onto PPC / E500 core.

Check Freescale's Website - there is a vendor list somewhere...
Check Denx' Website.

Don't worry about Linux. The guys here did a great job! 8-)
I am successfully running Kernel 2.4.2x and 2.6.10 on an
embedded Board with the MPC8540 - with just very little
tweaking from the official Kernel.

Have you decided what development System/HW you want
to use? There are several vendors who sell ready to use
854x boards with different add-ons and flavors.

Additionally, if it comes to some more add-ons (i.e.
Graphics and IDE on PCI you might re-use some of my
ideas.

> I've been in embedded OS / hardware area for many
> years, but a 100% newbie when it comes to Linux.

Welcome! And prepare for a steep learning curve. :-)


Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19
