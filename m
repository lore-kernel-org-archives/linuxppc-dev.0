Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AA7DC68A02
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Feb 2006 09:26:48 +1100 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1F4muZ-0006NJ-1x
	for linuxppc-embedded@ozlabs.org; Thu, 02 Feb 2006 23:26:43 +0100
Received: from dsl-202-45-109-210.vic.netspace.net.au ([202.45.109.210])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 02 Feb 2006 23:26:43 +0100
Received: from ronkbox-news by dsl-202-45-109-210.vic.netspace.net.au with
	local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 02 Feb 2006 23:26:43 +0100
To: linuxppc-embedded@ozlabs.org
From: Ron Kellam <ronkbox-news@yahoo.com>
Subject: Re: SPI flash kernel 2.4 driver
Date: Fri, 03 Feb 2006 09:26:15 +1100
Message-ID: <aj15u1dmpp9adens0ja7e9ciec8qo9379f@4ax.com>
References: <ITYDSI$4F4F62D0FA98B587B7D4335807D29D19@libero.it>
	<20060131211155.BF9193535E8@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@sea.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 31 Jan 2006 22:11:55 +0100, Wolfgang Denk <wd@denx.de> wrote:

>The Katix SPI framework  is  integrated  with  our  2.4  kernel;  see
>drivers/spi

It might be integrated, but it's seriously broken.  IIRC, the whole
chip select mechanism is not working, and the code still has a lot of
I2Cisms about it.

Regards,
Ron
