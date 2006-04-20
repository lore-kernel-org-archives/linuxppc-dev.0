Return-Path: <jgeissel@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id B2CEE67A2E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Apr 2006 23:09:02 +1000 (EST)
From: Arno Geissel <jgeissel@gmx.net>
To: linuxppc-embedded@ozlabs.org
Subject: Re: problem with watchdog/reboot MPC5200
Date: Thu, 20 Apr 2006 15:08:56 +0200
References: <F6AD7E21CDF4E145A44F61F43EE6D9396B20F9@tmnt04.transmode.se>
In-Reply-To: <F6AD7E21CDF4E145A44F61F43EE6D9396B20F9@tmnt04.transmode.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200604201508.56578.jgeissel@gmx.net>
Reply-To: jgeissel@gmx.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Confirmed! Using the MPC reset pin (instead of PORESET)
solves it.

Thank you all

Arno

> You first need to e.g. write a reset cmd (0x5050) to it or connect
> the processor's hardreset line to the flash device.

> Jaap-Jan

>
> I think you need to connect your flash reset pin to the MPC reset pin so
> that
> the CPU reset will reset the flash as well.
>
>  Jocke
