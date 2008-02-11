Return-Path: <jwboyer@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.188])
	by ozlabs.org (Postfix) with ESMTP id ED704DDE40
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Feb 2008 23:54:06 +1100 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so3442655rvf.9
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Feb 2008 04:54:03 -0800 (PST)
Date: Mon, 11 Feb 2008 06:53:20 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Ebony development board
Message-ID: <20080211065320.14a4485b@zod.rchland.ibm.com>
In-Reply-To: <200802110720.12842.sr@denx.de>
References: <47AE00FE.1000704@uid0.hu>
	<200802110720.12842.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 11 Feb 2008 07:20:12 +0100
Stefan Roese <sr@denx.de> wrote:

> Hi Zoltan,
> 
> On Saturday 09 February 2008, Zoltan HERPAI wrote:
> > I've recently got an Ebony board (440GP) with the original bootloader
> > (440GP 1.18 ROM Monitor) which I would like to replace with U-boot. Is
> > there a way to boot an U-boot image via TFTP to replace the bootloader,
> > or is it possible only with using a JTAG? I've googled through the
> > mailing list, but most of the related hits are dated back in 2004-2005,
> > they say no, one have to use JTAG, but some time passed since then, and
> > I would like to know if there is a way for this.
> 
> Does the original ROM monitor support writing to onboard FLASH? If yes, it 
> should be possible.

It doesn't.  Theoretically, you can boot Linux and use MTD on the flash
to load U-Boot.  I wouldn't recommend it without a JTAG debugger around
to fix things in case they get screwed up.

josh
