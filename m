Message-ID: <E1836A7F3557D311A14000805F9F36FC0141C6A0@usdfo011.usac.danfoss.net>
From: Hihn Jason <JasonHihn@DANFOSS.com>
To: "'navinb'" <ppc4@rediffmail.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: USB working on 823..?
Date: Thu, 16 May 2002 16:15:37 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Well, at least with the 832e, you can't.

The 823e was made for Kodak in the dawn of USB, before there was the
standard that we have today. As a result, there is a bug in the host mode of
the chip. Slave works fine though. You'll need another chip to do USB host.

I reserve the right to be wrong.
-Jason



-----Original Message-----
From: navinb [mailto:ppc4@rediffmail.com]
Sent: Thursday, May 16, 2002 9:56 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: USB working on 823..?



Hello ,

Has anybody got usb working successfully on mpc823.
I am trying hard to get the usb host controller properly
working on 823..
are there any know issue or patches available..?

Best Regards,


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
