Return-Path: <cclo@astri.org>
Received: from asiwss02.astri.org (mail2.astri.org [203.198.202.21])
	by ozlabs.org (Postfix) with ESMTP id 9AC0267B72
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Sep 2006 11:21:35 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Subject: RE: Wireless Linux(802.11) for Embedded PowerPC
Date: Thu, 7 Sep 2006 09:23:08 +0800
Message-ID: <A7B1E4DD46AA7046A4398F745240F29402737D68@ASPROEXG.astri.local>
From: "Chun Chung Lo" <cclo@astri.org>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: wei.li4@elf.mcgill.ca, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi,

This project is my university graduation project, so it is now stopped.
(I just finished some ugly prototypes :)

As I said before, I used ELDK for my project (since I am a student at
that moment, I really do not know how to manually build/compile a GNU
cross-platform toolchains), there is no WLAN drivers bundled inside the
toolkit. Also my WLAN card is based on Intersil Prism 2 chipset, so my
only choice is linux-wlan package. I do not know the project status, but
the driver stability seems OK for me. (No crash occurred during I do so
many ugly tests :)

But the performance and the compatibilty is quite good (provided that
the PCMCIA socket drirver is working properly) for a such small system
(MPC860 @ 50MHz).

Also I cannot see any drivers existing in the upstream kernel are really
support the "Intersil Prism 2 WLAN" cards (my card is differ from those
Orinoco cards and Hermes cards, also the drivers are also differ a lot).


If you are going to use Intersil Prism 2 cards/chips, I would suggest
you to use the linux-wlan driver (but seems this driver does not support
AP mode yet...)

Thanks.

Best regards,
Lo Chun Chung

-----Original Message-----
From: John W. Linville [mailto:linville@tuxdriver.com]=0D
Sent: Wednesday, 06 September, 2006 9:58 PM
To: Chun Chung Lo
Cc: wei.li4@elf.mcgill.ca; linuxppc-embedded@ozlabs.org
Subject: Re: Wireless Linux(802.11) for Embedded PowerPC


On Wed, Sep 06, 2006 at 09:30:00AM +0800, Chun Chung Lo wrote:

> 1. WLAN card driver: linux-wlan -- http://www.linux-wlan.org/

Is this project even still active?  The last update to the page was 2.5
years ago (2/2004), and many of the links are broken...

Do the prism drivers in the upstream kernel not work for you?

John
--=0D
John W. Linville
linville@tuxdriver.com

This message (including any attachments) is for the named addressee(s)'s=
 use only. It may contain
sensitive, confidential, private proprietary or legally privileged=
 information intended for a
specific individual and purpose, and is protected by law. If you are not=
 the intended recipient,
please immediately delete it and all copies of it from your system, destroy=
 any hard copies of it
and notify the sender. Any use, disclosure, copying, or distribution of=
 this message and/or any
attachments is strictly prohibited.
