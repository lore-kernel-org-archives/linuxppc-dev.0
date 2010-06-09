Return-Path: <emillbrandt@dekaresearch.com>
Received: from dekaexchange07.deka.local (mail.dekaresearch.com
	[208.65.175.196]) by ozlabs.org (Postfix) with ESMTP id 89EA1B7D4F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Jun 2010 00:23:45 +1000 (EST)
From: Eric Millbrandt <emillbrandt@dekaresearch.com>
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>, Wolfgang Denk
	<wd@denx.de>
Date: Wed, 9 Jun 2010 10:24:49 -0400
Subject: RE: [PATCH 0/2] mpc5200 ac97 gpio reset
Message-ID: <0A40042D85E7C84DB443060EC44B3FD3253ECB8C85@dekaexchange07.deka.local>
References: <1276015562-28928-1-git-send-email-emillbrandt@dekaresearch.com>
	<AANLkTimIs90kR5uqhdBQ02oSd94dn08sOITm51Ylrl4-@mail.gmail.com>
	<20100609061330.620AC14E867@gemini.denx.de>
	<20100609103046.GC5618@opensource.wolfsonmicro.com>
In-Reply-To: <20100609103046.GC5618@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> Sent: Wednesday, June 09, 2010 06:31
> To: Wolfgang Denk
> Cc: Jon Smirl; Eric Millbrandt; linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH 0/2] mpc5200 ac97 gpio reset
--snip--
> It might, however, be sensible to make the GPIO based reset be optional
> based on having the OF data for the GPIOs.  That way existing DTs will
> work without changes and systems that can use the reset implementation
> in the controller will be able to do so.

This is a reasonable request.  I will respin the patch to do this.

Eric Millbrandt

This e-mail and the information, including any attachments, it contains are=
 intended to be a confidential communication only to the person or entity t=
o whom it is addressed and may contain information that is privileged. If t=
he reader of this message is not the intended recipient, you are hereby not=
ified that any dissemination, distribution or copying of this communication=
 is strictly prohibited. If you have received this communication in error, =
please immediately notify the sender and destroy the original message.

Thank you.

Please consider the environment before printing this email.
