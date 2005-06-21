Return-Path: <wd@denx.de>
Received: from mailout06.sul.t-online.com (mailout06.sul.t-online.com
	[194.25.134.19]) by ozlabs.org (Postfix) with ESMTP id 2106667A6B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Jun 2005 06:19:01 +1000 (EST)
To: j.lu@tiesse.com
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 21 Jun 2005 16:48:13 +0200."
	<200506211648.AA102695630@tiesse.com>
Date: Tue, 21 Jun 2005 22:18:34 +0200
Sender: wd@denx.de
Message-Id: <20050621201839.F40E0C1510@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: isp1362 usb driver 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

in message <200506211648.AA102695630@tiesse.com> you wrote:
>
> sorry for my persistence, now I try to go to more detail:

I'm afraid I can't help much. The only board with a  ISP1362  I  have
access  to at the moment has just the device interface equipped, so I
cannot run any real tests on the host port.

> Jan  1 01:01:30 IMOLA kernel: hub.c: USB new device connect on 
> bus2/2, assigned device number 2
> Jan  1 01:01:33 IMOLA kernel: usb_control/bulk_msg: timeout
> Jan  1 01:01:45 IMOLA last message repeated 4 times
> Jan  1 01:01:45 IMOLA kernel: usb.c: couldn't get all of config 
> descriptors
> Jan  1 01:01:45 IMOLA kernel: usb.c: unable to get device 2 
> configuration (error=-110)

Which sort of device is it what you connected? Are  you  sure  it  is
working  under  Linux at all? Did you test it on a standard x86 Linux
PC with a 2.4.2x kernel?


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A fanatic is a person who can't change his mind and won't change  the
subject.                                          - Winston Churchill
