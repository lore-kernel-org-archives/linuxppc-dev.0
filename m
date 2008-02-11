Return-Path: <SRS0=RTqQ=TA=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id B4BF3DDDF6
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Feb 2008 17:20:25 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Ebony development board
Date: Mon, 11 Feb 2008 07:20:12 +0100
References: <47AE00FE.1000704@uid0.hu>
In-Reply-To: <47AE00FE.1000704@uid0.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802110720.12842.sr@denx.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Zoltan,

On Saturday 09 February 2008, Zoltan HERPAI wrote:
> I've recently got an Ebony board (440GP) with the original bootloader
> (440GP 1.18 ROM Monitor) which I would like to replace with U-boot. Is
> there a way to boot an U-boot image via TFTP to replace the bootloader,
> or is it possible only with using a JTAG? I've googled through the
> mailing list, but most of the related hits are dated back in 2004-2005,
> they say no, one have to use JTAG, but some time passed since then, and
> I would like to know if there is a way for this.

Does the original ROM monitor support writing to onboard FLASH? If yes, it 
should be possible.

Best regards,
Stefan
