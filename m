Return-Path: <pantelis@embeddedalley.com>
Received: from smtp102.biz.mail.re2.yahoo.com (smtp102.biz.mail.re2.yahoo.com
	[68.142.229.216]) by ozlabs.org (Postfix) with SMTP id 0E589DDE31
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 Feb 2007 23:52:25 +1100 (EST)
In-Reply-To: <9F3F0A752CAEBE4FA7E906CC2FBFF57C069AED@MERCURY.inside.istor.com>
References: <OFA2B855F5.8FEEC16C-ON8825728C.000C6AC9-8825728C.000C740E@selinc.com>
	<9F3F0A752CAEBE4FA7E906CC2FBFF57C069AEA@MERCURY.inside.istor.com>
	<9F3F0A752CAEBE4FA7E906CC2FBFF57C069AED@MERCURY.inside.istor.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=UTF-8; delsp=yes; format=flowed
Message-Id: <D0255586-C0FC-4E2A-B829-74D79A8D02CD@embeddedalley.com>
From: Pantelis Antoniou <pantelis@embeddedalley.com>
Subject: Re: CPM FCC1 & FCC2
Date: Mon, 26 Feb 2007 14:45:38 +0200
To: Charles Krinke <ckrinke@istor.com>
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


On 25 =CE=A6=CE=B5=CE=B2 2007, at 12:19 =CE=A0=CE=9C, Charles Krinke =
wrote:

> In our design for an 8541 board, we are going to be using FCC1 & =20
> FCC2 in addition to the FAST controller.
>
> I have been looking through the Linux-2.6.17.11 source we are using =20=

> and although I can find some references to MPC85xx_CPM_FCC1, I =20
> cannot quite identify the driver used with the 85xx in Linux.
>
> Can someone help me determine the name of the appropriate driver =20
> for the two FCC sections of the 8541 please?
>
> Charles
>
>

Hi Charles,

There's FCC support in the fs_enet driver, but I'm afraid it's not being
ported to the 85xx yet I'm afraid. The only supported family for the =20
fcc's is 82xx.

It shouldn't be very hard to add this, and I'd be glad to help with =20
some pointers.

Regards

-- Pantelis
