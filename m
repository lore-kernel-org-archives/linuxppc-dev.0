Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 0A965DDDDB
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 18 Nov 2007 11:51:22 +1100 (EST)
To: Juergen Beisert <jbe@pengutronix.de>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: MPC5200B: Linux does not recognise the external PCI card
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 15 Nov 2007 15:21:41 +0100."
	<200711151521.43047.jbe@pengutronix.de>
Date: Sun, 18 Nov 2007 01:51:20 +0100
Sender: wd@denx.de
Message-Id: <20071118005120.63E33247F1@gemini.denx.de>
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

In message <200711151521.43047.jbe@pengutronix.de> you wrote:
>
> > Which card?
> 
> Its a NEC USB 2.0 card.

Are you absolutely sure that this card is 3.3V clean, i. e. that the
PCI slot on the Lite5200B provides all the needed voltages?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A supercomputer is a machine that runs an endless loop in 2 seconds.
