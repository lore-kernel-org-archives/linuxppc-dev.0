Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 01B39689C0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Jan 2006 18:05:21 +1100 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ExIH5-0000DY-Av
	for linuxppc-embedded@ozlabs.org; Fri, 13 Jan 2006 07:18:59 +0100
Received: from dsl-202-45-109-210.vic.netspace.net.au ([202.45.109.210])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Fri, 13 Jan 2006 07:18:59 +0100
Received: from ronkbox-news by dsl-202-45-109-210.vic.netspace.net.au with
	local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Fri, 13 Jan 2006 07:18:59 +0100
To: linuxppc-embedded@ozlabs.org
From: Ron Kellam <ronkbox-news@yahoo.com>
Subject: Re: Can ELDK 3.1.1 compile Linux 2.6 Kernel?
Date: Fri, 13 Jan 2006 17:18:39 +1100
Message-ID: <98hes19r3jn7dfv2jmr9r5qenprqfltg5k@4ax.com>
References: <20060111083657.77699.qmail@web53707.mail.yahoo.com>
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

I have the DENX 2.6.14 kernel quite happily compiling using ELDK
3.1.1, and it runs fine.  My platform is a custom MPC8247 (ppc) system
with serial, ethernet, I2C & SPI drivers all working fine under
2.6.14.

I had no luck compiling any of the 2.6.15rcX or 2.6.denx trees under
ELDK 3.1.1 - same compile probs as yours.

Regards,
Ron
