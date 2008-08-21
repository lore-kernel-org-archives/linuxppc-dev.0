Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 8F779DE436
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 04:45:09 +1000 (EST)
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Strange behavior with I2C on Sequoia board
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <Pine.LNX.4.64.0808211630170.20704@vixen.sonytel.be>
References: <48AC84D9.8050809@harris.com>
	<1219279463.26429.35.camel@jdub.homelinux.org>
	<20080820231828.3c22da08@lappy.seanm.ca>
	<200808211151.40499.sr@denx.de>
	<48AD5FD1.1090809@ru.mvista.com> <48AD6D3B.6030701@harris.com>
	<Pine.LNX.4.64.0808211630170.20704@vixen.sonytel.be>
Date: Thu, 21 Aug 2008 20:45:00 +0200
Sender: wd@denx.de
Message-Id: <20080821184500.8DD3F248FF@gemini.denx.de>
Cc: Stefan Roese <sr@denx.de>, linuxppc-dev@ozlabs.org,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Geert,

In message <Pine.LNX.4.64.0808211630170.20704@vixen.sonytel.be> you wrote:
>
> Can you actually boot a plain uImage from U-Boot?

yes, of course you can (you will need a device tree, too).

> I've just gave it a try.  While arch/powerpc/boot/cuImage.sequoia boots fine,
> after `make uImage', I get arch/powerpc/boot/uImage, but it doesn't boot:
> 
> | ## Booting image at 00100000 ...
> |    Image Name:   Linux-2.6.27-rc4-dirty
> |    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
> |    Data Size:    1398827 Bytes =  1.3 MB
> |    Load Address: 00000000
> |    Entry Point:  00000000
> |    Verifying Checksum ... OK
> |    Uncompressing Kernel Image ... Error: inflate() returned -3
> | GUNZIP ERROR - must RESET board to recover
> | 
> | U-Boot 1.2.0-gc0c292b2 (Jun  5 2007 - 07:16:12)
> 
> and I'm back to U-Boot...

See the FAQ: http://www.denx.de/wiki/view/DULG/LinuxUncompressingError

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A conservative is a man who believes that nothing should be done for
the first time.                                   - Alfred E. Wiggam
