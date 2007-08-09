Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C6715DDE44
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Aug 2007 03:02:01 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IJBOS-0007xh-Kj
	for linuxppc-embedded@ozlabs.org; Thu, 09 Aug 2007 19:01:52 +0200
Received: from dslb-084-056-133-219.pools.arcor-ip.net ([84.56.133.219])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 09 Aug 2007 19:01:52 +0200
Received: from mls.JOFT by dslb-084-056-133-219.pools.arcor-ip.net with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 09 Aug 2007 19:01:52 +0200
To: linuxppc-embedded@ozlabs.org
From: Joachim =?ISO-8859-1?Q?F=F6rster?= <mls.JOFT@gmx.de>
Subject: Re: BUG-REPORT Re: ml403 ac97 driver
Date: Thu, 09 Aug 2007 19:01:42 +0200
Message-ID: <1186678902.16797.18.camel@localhost>
References: <1185698888.6397.37.camel@localhost>
	<11922613.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain
In-Reply-To: <11922613.post@talk.nabble.com>
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

Hi Qin Lin,

sorry for my late answer.

On Tue, 2007-07-31 at 04:49 -0700, Qin Lin wrote:
> When i used the aplay to test the drive first time,it played well. But 
> after restart the board 
> it is not well again.

Well, I don't think the problem occurs due to the restart of your
board ...

> # aplay yonggan.wav
> Playing WAVE 'yonggan.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
> Stereo
> [  258.518119] Kernel stack overflow in process c039ec00, r1=c3e0bf50

... but unfortunately I can't tell how such an error results from the
driver. Are you able to reproduce it?
Since the driver "works", I never got such an error nor another kernel
panic/error.

[The only thing that comes to my mind is the very high interrupt volume,
because of the very small size (32 byte) of the playback FIFO (of the
AC97 controller) => hardware issue. But, since interrupts are _disabled_
during execution of interrupt handlers, I am sure that this cannot be
the source of the problem.]

 Joachim
