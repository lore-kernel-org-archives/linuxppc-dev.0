Return-Path: <jgeissel@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id EFE4567A6B
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 May 2006 00:15:05 +1000 (EST)
From: Arno Geissel <jgeissel@gmx.net>
To: linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200 I2C unstable?
Date: Wed, 3 May 2006 16:15:01 +0200
References: <200605031608.47579.kimmo.surakka@oxinst.fi>
In-Reply-To: <200605031608.47579.kimmo.surakka@oxinst.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605031615.01418.jgeissel@gmx.net>
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

As far as I know there are hardware problems on the MPC5200 I2C
interface. They should be solved in the revision B

Arno

> Hi,
>
> I'm using a MPC5200 based board (namely TQM5200) and the
> linuxppc_2_4_devel-2005-10-25-1440 kernel from denx.de. To get the serial
> ports more stable, I've applied the serial port patch by Achim Machura (can
> be found in
> http://marc.theaimsgroup.com/?l=linuxppc-embedded&m=112901824515097&w=2).
> The patch needed small adjustments, but nothing too large -- mostly
> different line numbers.
>
> Also, to get the first I2C interface to work, I've had to change the file
> drivers/i2c/i2c-tqm5200.c followingly:
>
> -#define MPC5xxx_I2C1_ENABLE    0       /* Disable  */
> +#define MPC5xxx_I2C1_ENABLE    1       /* Enable   */
>
> The code compiles OK, but the I2C bus gets stuck after a short while. Has
> anyone else experienced something similar? I tried to Google for
> information but didn't find anything relevant. Maybe I just didn't know the
> right keywords to search for?
>
> Thanks in advance,
>
> Kimmo Surakka
>
> This message has been scanned by F-Secure Anti-Virus
>
> ###  OXFORD INSTRUMENTS   http://www.oxford-instruments.com/  ###
>
> Unless stated above to be non-confidential, this E-mail and any
> attachments are private and confidential and are for the addressee
> only and may not be used, copied or disclosed save to the addressee.
> If you have received this E-mail in error please notify us upon receipt
> and delete it from your records. Internet communications are not secure
> and Oxford Instruments is not responsible for their abuse by third
> parties nor for any alteration or corruption in transmission.
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
