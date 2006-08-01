Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9C5ED67B63
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Aug 2006 15:15:08 +1000 (EST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1G7mas-0003wR-3a
	for linuxppc-embedded@ozlabs.org; Tue, 01 Aug 2006 07:15:02 +0200
Received: from adsl-63-204-19-188.dsl.snfc21.pacbell.net ([63.204.19.188])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Tue, 01 Aug 2006 07:15:02 +0200
Received: from chichkov by adsl-63-204-19-188.dsl.snfc21.pacbell.net with
	local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Tue, 01 Aug 2006 07:15:02 +0200
To: linuxppc-embedded@ozlabs.org
From: "Dmitry Chichkov" <chichkov@gmail.com>
Subject: Re: U-Boot and kernel 2.6 
Date: Mon, 31 Jul 2006 22:12:45 -0700
Message-ID: <eamnsh$v4b$1@sea.gmane.org>
References: <4418.62.48.238.11.1086803257.squirrel@alumni.deec.uc.pt>
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

Hi Ricardo,

I would recommend not to try old versions of U-Boot ("from 2.4") with new 
linux kernels ("2.6").
We had some troubles with invalid memory mappings in this configuration.

-- Regards, Dmitry Chichkov




"Ricardo DIz" <rdiz@alumni.deec.uc.pt> ???????/???????? ? ???????? 
?????????: news:4418.62.48.238.11.1086803257.squirrel@alumni.deec.uc.pt...
>
> Hi,
>
> I'm trying to boot a custom 860T board using the latest kernel from
> linuxppc-2.5. The board is currently using a variation of an old version
> of U-Boot (0.2.0) along with a hacked 2.4.20 linux kernel version.
>
> My first aim is to boot a simple kernel and make it get to a shell. For
> that I compiled the kernel, but did not compiled u-boot with a recent
> version.
>
> When booting, the kernel got uncompressed, but then it resets! I presume
> the watchdog (which is enabled), is resetting the processor, so I guess
> booting just stalls. Was there any changes in the way parameters were
> received by the kernel since 2.4.20?
>
> Oh, I forgot to mention the compiler. I'm still using a gcc 2.95
> cross-compiler, altough I tried using a gcc 3.2 cross-compiler for the
> 8260 once, but got the same result.
>
> I followed a recent thread very similar to this, but that turned out to be
> just a matter of UART configuration, and I don't thinks this is the case.
>
> Any thoughts?
>
> Thanks in advance,
> Ricardo Diz
>
> ** Sent via the linuxppc-embedded mail list. See 
> http://lists.linuxppc.org/
>
> 
